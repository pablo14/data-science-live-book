create_site <- function(is_pdf=F, high)
{
  fn="data-science-live-book.Rmd"
  if (file.exists(fn)) file.remove(fn)
  rmarkdown::clean_site()
  if(!is_pdf)
  {
    rmarkdown::render_site(output_format = 'bookdown::gitbook', encoding = 'UTF-8')
  } else {
    rmarkdown::render_site(output_format = bookdown::pdf_book(template='template.tex', latex_engine = "pdflatex"))
  }
}


create_site(T)
create_site(F)




