# Variables
R = Rscript
SHELL := /bin/bash

# Colors for output
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
CYAN := \033[0;36m
RESET := \033[0m

.PHONY: help install run data manifest clean

# Help command to list available commands
help:
	@echo -e "$(CYAN)Available commands:$(RESET)"
	@echo -e "  $(YELLOW)make install$(RESET)   - Install required R packages"
	@echo -e "  $(YELLOW)make data$(RESET)      - Process raw data into data/processed/"
	@echo -e "  $(YELLOW)make run$(RESET)       - Run the Shiny app locally"
	@echo -e "  $(YELLOW)make manifest$(RESET)  - Write manifest.json for Connect Cloud"
	@echo -e "  $(YELLOW)make clean$(RESET)     - Remove processed data (requires confirmation)"

# Install required R packages
install:
	@echo -e "$(GREEN)Installing required R packages...$(RESET)"
	@$(R) -e "install.packages(c('shiny','dplyr','readr','lubridate','ggplot2','tidyr','rsconnect'), repos='https://cloud.r-project.org')"

# Process raw data into .rds
data:
	@echo -e "$(CYAN)Processing raw data into .rds format...$(RESET)"
	@$(R) scripts/process_data.R
	@echo -e "$(GREEN)Data processing complete.$(RESET)"

# Run the Shiny app
run:
	@echo -e "$(GREEN)Running Shiny app locally...$(RESET)"
	@$(R) -e "shiny::runApp('.', launch.browser = TRUE)"

# Write manifest.json for Connect Cloud
manifest:
	@echo -e "$(CYAN)Writing manifest.json for Connect Cloud...$(RESET)"
	@$(R) -e "rsconnect::writeManifest()"
	@echo -e "$(GREEN)manifest.json created.$(RESET)"

# Clean processed data with confirmation
clean:
	@echo -e "$(RED)WARNING: This will remove files in data/processed/$(RESET)"
	@read -p "Are you sure you want to continue? [y/N] " -n 1 -r; \
	echo ""; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo -e "$(YELLOW)Cleaning processed data...$(RESET)"; \
		rm -rf data/processed/*; \
		echo -e "$(GREEN)Clean complete.$(RESET)"; \
	else \
		echo -e "$(CYAN)Clean aborted.$(RESET)"; \
	fi