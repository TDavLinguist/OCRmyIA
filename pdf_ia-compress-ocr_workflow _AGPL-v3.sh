# This bash script (c) 2024 Tyler D. Davis, Licensed under AGPL-v3
#!/bin/bash

#The input PDF is the first argument
INPUT_PDF=$1
PDF_BASE="${INPUT_PDF%.*}"
TMP_DIR=/tmp/
DPI=300

#Perform OCR on PDF using ocrmypdf.
LOSS_OCR_TMP="$TMP_DIR""$PDF_BASE"-loss-ocr.pdf
echo "Now performing lossless OCR on input PDF..."
ocrmypdf -O1 --output-type pdf $INPUT_PDF $LOSS_OCR_TMP || { echo "OCR Failed. Sorry about that."; exit 1; }
echo "OCR completed successfully!"
#Generate necessary json and hocr file from PDF
TMP_JSON="$TMP_DIR"$PDF_BASE"_"$(date +%H%M)".json"
TMP_HOCR="$TMP_DIR"$PDF_BASE"_"$(date +%H%M)".hocr"
echo "Extracting necessary JSON metadata from OCR'd PDF"
pdf-metadata-json $LOSS_OCR_TMP 2>/dev/null > $TMP_JSON
# Check to see whether or not the file was successfully created.
echo "JSON for $LOSS_OCR_TMP generated successfully!"
if [ ! -f $TMP_JSON ]; then
	echo "JSON file not created, for some reason!"; exit 1;
fi
echo "Generating necessary HOCR file before compressing OCR'd PDF"
pdf-to-hocr -f $LOSS_OCR_TMP -J $TMP_JSON > $TMP_HOCR
# Check to see whether or not the file was successfully created.
if [ ! -f $TMP_HOCR ]; then
	echo "HOCR file not created, for some reason!"; exit 1;
fi
echo "HOCR file for $LOSS_OCR_TMP generated successfully!"
#Run recode_pdf on the file given the proper inputs
#First set variable for compressed PDF output.
PDF_COMP="$PDF_BASE"-ia-ocr.pdf
echo "Compressing OCR'd PDF with IA algorithms..."
recode_pdf -P $LOSS_OCR_TMP -T $TMP_HOCR --dpi $DPI -o $PDF_COMP
# Check to see whether or not the file was successfully created.
if [ ! -f $PDF_COMP ]; then
	echo "Compressed PDF creation failed :("; exit 1;
fi
echo "PDF compressed successfully!"
#Delete Temporary files
rm $LOSS_OCR_TMP $TMP_JSON $TMP_HOCR
echo "Enjoy your compressed OCR'd PDF!"
echo "File saved as $PDF_COMP"
exit
