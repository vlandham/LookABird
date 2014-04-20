
BOOK_FILE_NAME = look_a_bird
TEMP_DIR = temp

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template ../_layouts/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image

MOBI_BUILDER = kindlegen


combine:
	mkdir -p $(TEMP_DIR)
	cat _posts/*.md | tools/remove_header.rb > $(TEMP_DIR)/$(BOOK_FILE_NAME).md
	cp -r img/ temp/img

pdf: combine
	cd $(TEMP_DIR) && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(BOOK_FILE_NAME).md -o $(BOOK_FILE_NAME).pdf

epub: combine
	cd $(TEMP_DIR) && $(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) img/title.png $(BOOK_FILE_NAME).md -o $(BOOK_FILE_NAME).epub

mobi: epub
	cd $(TEMP_DIR) && $(MOBI_BUILDER) $(BOOK_FILE_NAME).epub

clean:
	rm -f $(BOOK_FILE_NAME).pdf
	rm -rf $(TEMP_DIR)
