# 2026-05-28-batch_render_3page.R
# Renders all_3page_sector_report_template_complete_combined.Rmd for every
# CGE sector found in the dataset.
#
# Usage:
#   1. Open an R session (or RStudio terminal) with working directory set to the
#      Applied Research Project folder.
#   2. Adjust the four path constants in the Config section if needed.
#   3. Run: source("2026-05-28-batch_render_3page.R")
#
# The script pre-loads df_final once and passes it as a global object so each
# child render avoids re-reading the ~130 MB RDS file.

library(rmarkdown)
library(readr)

# ── Config ────────────────────────────────────────────────────────────────────
rmd_file    <- "all_3page_sector_report_template_complete_combined.Rmd"
data_file   <- "dn18_23_Cleaning&SectorAggregation_FINAL.rds"
decomp_file <- "LP_decomposition_CGEsector.xlsx"
output_dir  <- "Final_sector_3page_reports"

# Set to a character vector of sector names to render only a subset, e.g.:
#   target_sectors <- c("Education", "ICT and publishing")
# Set to NULL to render all 34 sectors.
target_sectors <- NULL

# ── Validate inputs ───────────────────────────────────────────────────────────
if (!file.exists(rmd_file))    stop("Rmd not found: ", rmd_file)
if (!file.exists(data_file))   stop("Data file not found: ", data_file)
if (!file.exists(decomp_file)) stop("Decomp file not found: ", decomp_file)

# ── Load shared data once ─────────────────────────────────────────────────────
cat("Loading df_final...\n")
df_final <- read_rds(data_file)

# Expose to global env so the child render environment (parent = .GlobalEnv)
# inherits it and skips its own readRDS call.
assign("df_final", df_final, envir = .GlobalEnv)
cat("  Loaded:", nrow(df_final), "rows,", ncol(df_final), "columns.\n")

# ── Sector list ───────────────────────────────────────────────────────────────
all_sectors <- sort(unique(df_final$CGE_sectorname))
cat("Found", length(all_sectors), "sectors in dataset.\n")

sectors <- if (!is.null(target_sectors)) {
  missing <- setdiff(target_sectors, all_sectors)
  if (length(missing) > 0) warning("Sectors not found in data: ", paste(missing, collapse = ", "))
  intersect(target_sectors, all_sectors)
} else {
  all_sectors
}
cat("Will render", length(sectors), "sector(s).\n\n")

# ── Output folder ─────────────────────────────────────────────────────────────
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# ── Render loop ───────────────────────────────────────────────────────────────
ok        <- character(0)
fail      <- character(0)
fail_msg  <- list()
start_all <- proc.time()

for (i in seq_along(sectors)) {
  sector    <- sectors[i]
  safe_name <- gsub("[^A-Za-z0-9]+", "_", sector)
  out_file  <- file.path(output_dir, paste0(safe_name, "_3page.html"))

  cat(sprintf("[%d/%d] Rendering: %s\n", i, length(sectors), sector))
  cat(sprintf("  → %s\n", out_file))

  t0 <- proc.time()

  res <- tryCatch({
    rmarkdown::render(
      input         = rmd_file,
      params        = list(
        target_sector = sector,
        data_path     = data_file,
        decomp_path   = decomp_file
      ),
      output_file   = out_file,
      knit_root_dir = getwd(),
      envir         = new.env(parent = .GlobalEnv),
      quiet         = TRUE
    )
    TRUE
  }, error = function(e) {
    message("  FAILED: ", conditionMessage(e))
    fail_msg[[sector]] <<- conditionMessage(e)
    FALSE
  })

  elapsed <- (proc.time() - t0)[["elapsed"]]

  if (isTRUE(res)) {
    ok <- c(ok, sector)
    cat(sprintf("  Done in %.1f s.\n", elapsed))
  } else {
    fail <- c(fail, sector)
    cat(sprintf("  Failed after %.1f s.\n", elapsed))
  }
}

# ── Summary ───────────────────────────────────────────────────────────────────
total_elapsed <- (proc.time() - start_all)[["elapsed"]]

cat("\n──────────────────────────────────────────────\n")
cat("Render summary\n")
cat("  Succeeded:", length(ok), "\n")
cat("  Failed   :", length(fail), "\n")
cat("  Total time:", sprintf("%.1f s (%.1f min)\n", total_elapsed, total_elapsed / 60))

if (length(fail) > 0) {
  cat("\nFailures:\n")
  for (s in fail) {
    msg <- if (!is.null(fail_msg[[s]])) fail_msg[[s]] else "unknown error"
    cat("  -", s, ":", msg, "\n")
  }
}

if (length(ok) > 0) {
  cat("\nSuccessful outputs saved under:", normalizePath(output_dir), "\n")
}
