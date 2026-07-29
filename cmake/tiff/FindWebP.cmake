# TIFF's configuration probes WebP before evaluating the `webp` option.  The
# Cocos runtime does not need TIFF WebP compression, so avoid both host lookup
# and the engine's legacy FindWebP module here.
set(WebP_FOUND FALSE)
