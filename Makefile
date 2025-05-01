# Makefile for automating Q6 analysis

# File paths
NOTEBOOK=./Code/Q6_code.ipynb
OUTPUT_NOTEBOOK=Q6_code_output.ipynb

# Default target
all: run_notebook save_model

# Run notebook and save output with execution
run_notebook:
	jupyter nbconvert --to notebook --execute $(NOTEBOOK) --output $(OUTPUT_NOTEBOOK)



# Clean output files
clean:
	rm -f $(OUTPUT_NOTEBOOK)

# Install dependencies (optional)
install_deps:
	pip install pandas matplotlib seaborn scikit-learn joblib jupyter numpy contextily
	