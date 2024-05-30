library(tidyverse)
library(palmerpenguins)
library(quarto)

quarto_render(
  input = "report.qmd",
  output_file = "Dream.html",
  execute_params = list(island = "Dream")
)

islands <-
  penguins |>
  distinct(island) |>
  pull(island) |>
  as.character()

reports <-
  tibble(
    input = "report.qmd",
    output_file = str_glue("{islands}.html"),
    execute_params = map(islands, ~ list(island = .))
  )

pwalk(reports, quarto_render)
