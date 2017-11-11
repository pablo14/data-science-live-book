create_site <- function(is_pdf=F)
{
  fn="data-science-live-book.Rmd"
  if (file.exists(fn)) file.remove(fn)
  rmarkdown::clean_site()
  if(!is_pdf)
  {
    rmarkdown::render_site(output_format = 'bookdown::gitbook', encoding = 'UTF-8')
  } else {
    rmarkdown::render_site(output_format = bookdown::pdf_book(template='template.tex', latex_engine = "pdflatex",
                                                              split_bib = T,toc_unnumbered=F))
  }
}


create_site(F)
#create_site(F)




rmarkdown::render_site(output_format =  bookdown::epub_book(toc=T,toc_depth = 2), encoding = 'UTF-8')

