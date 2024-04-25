# OCRmyIA
Perform OCR operations on PDFs and then compress them with the [Internet Archive](htttps://www.archive.org)'s code.
# ABout the code
I am terrible at BASH and even worse at Python so I welcome and encourage any and all pull requests to improve my code. It's essentially a workflow recipe that depends on other pieces of code to work. I will probably add more scripts here later that do different things. I originally intended to license it as GPL-2, but I've decided to release it as AGPL-3.
# Prerequisites
* GNU/Linux OS with GNU Core Utils
* [OCRmyPDF](https://ocrmypdf.readthedocs.io/en/latest/) (Tested on >= 1.4.0)
* [archive-pdf-tools](https://git.archive.org/merlijn/archive-pdf-tools) Note: Due to [a bug](https://github.com/pymupdf/PyMuPDF/issues/3381) you should really modify the requirements.txt to install pymupdf v1.21.0 and not the latest version. This bug appears to only affect the archive-pdf-tools script.
* [archive-hocr-tools](https://git.archive.org/merlijn/archive-hocr-tools) (these should install when installing `archive-pdf-tools`)
