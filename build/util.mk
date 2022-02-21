
# if you want to find out the value of a makefile variable, just: make print-VARIABLE (source: https://www.cmcrossroads.com/article/printing-value-makefile-variable)
print-%  : ; @echo $* = $($*)