#' Process Raster Medial Axis
#'
#' Computes medial axis, width, and geographic coordinates from a raster image.
#'
#' @param raster_path Path to the raster image.
#' @param spatial_resolution Spatial resolution of the raster in meters (default 10).
#' @param crs_epsg EPSG code for the coordinate reference system (default 32616).
#'
#' @return A SpatialLinesDataFrame containing centerline geometry, width,
#'         longitude, latitude, and label.
#'
#' @importFrom raster raster values extent crs projection
#' @importFrom spatstat.geom as.im
#' @importFrom EBImage bwlabel propagate
#' @importFrom spatstat.geom as.owin
#' @importFrom spatstat.geom medialaxis
#' @importFrom sp SpatialLinesDataFrame CRS coordinates
#' @importFrom sf st_as_sf st_centroid st_coordinates
#'
#' @export
process_raster_medial_axis <- function(raster_path, spatial_resolution = 10, crs_epsg = 32616) {
    raster_obj <- raster::raster(raster_path)
    img <- raster::values(raster_obj)
    img[is.na(img)] <- 0
    img <- img > 0
    img_im <- spatstat.geom::as.im(matrix(img, nrow = raster::nrow(raster_obj), ncol = raster::ncol(raster_obj)))
    labeled_img <- EBImage::bwlabel(img_im$v)

    centerline_data <- list()
    width_data <- list()
    label_values <- unique(labeled_img[labeled_img > 0])

    for (label_val in label_values) {
        region_mask <- labeled_img == label_val
        region_owin <- spatstat.geom::as.owin(region_mask)
        skeleton_data <- spatstat.geom::medialaxis(region_owin)

        if (length(skeleton_data$x) > 1) {
            coords <- cbind(skeleton_data$x, skeleton_data$y)
            geo_coords <- raster::extent(raster_obj)[1] + coords[, 1] * raster::res(raster_obj)[1]
            geo_coords_y <- raster::extent(raster_obj)[3] + coords[, 2] * raster::res(raster_obj)[2]

            centerline <- sp::SpatialLines(list(sp::Lines(list(sp::Line(cbind(geo_coords, geo_coords_y))), ID = as.character(label_val))), proj4string = raster::crs(raster_obj))
            centerline_sf <- sf::st_as_sf(centerline)
            centroid_coords <- sf::st_coordinates(sf::st_centroid(centerline_sf))
            width_pixels <- max(skeleton_data$dist)
            width_meters <- width_pixels * spatial_resolution

            centerline_data[[length(centerline_data) + 1]] <- data.frame(Label = label_val, geometry = centerline_sf)
            width_data[[length(width_data) + 1]] <- data.frame(Label = label_val, Width = width_meters)
        } else {
            print(paste("Skipping region", label_val, "due to insufficient skeleton points."))
        }
    }
    df_centerline <- do.call(rbind, centerline_data)
    df_width
