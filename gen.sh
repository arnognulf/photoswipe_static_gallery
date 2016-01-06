#!/bin/bash
{
cat template-header.html
rm -rf images
mkdir -p images
mkdir -p images/thumbnails
for ORIGIMAGE in "$@"
do

convert -scale 1280 -auto-orient "${ORIGIMAGE}" images/${ORIGIMAGE##*/}
FULLIMAGE="images/${ORIGIMAGE##*/}"
IMAGESIZE=$(identify ${FULLIMAGE} |cut -d" " -f3)
convert -scale 360 -gravity Center -crop 240x240+0+0 -auto-orient "${ORIGIMAGE}" images/thumbnails/${ORIGIMAGE##*/}
THUMBIMAGE="images/thumbnails/${ORIGIMAGE##*/}"

cat <<EOF
<figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
<a href="${FULLIMAGE}" itemprop="contentUrl" data-size="${IMAGESIZE}">
<img src="${THUMBIMAGE}" itemprop="thumbnail" alt="Image description" />
</a>
<figcaption itemprop="caption description">${FULLIMAGE##*/}</figcaption>
</figure>
EOF
done

cat template-footer.html
} > index.html

