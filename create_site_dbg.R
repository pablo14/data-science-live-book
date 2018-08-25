create_book <- function(type)
{
  fn="data-science-live-book.Rmd"
  if (file.exists(fn)) file.remove(fn)
  rmarkdown::clean_site()

  if(type=='pdf')
  {
    rmarkdown::render_site(output_format =
                             bookdown::pdf_book(template='template.tex',
                                                latex_engine = "pdflatex",
                                                toc_unnumbered=F))
  } else if(type=='html'){
    rmarkdown::render_site(output_format = 'bookdown::gitbook',
                           encoding = 'UTF-8')
  } else {
    print('nope')
    }
}

## Creating the PDF
create_book('pdf')

## Creating the HTML
create_book('html')

## To create thhe epub, use the Build Book icon on RStudio.
