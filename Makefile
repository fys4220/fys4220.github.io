html:
	jupyter-book build --all fys4220-jbook
latex:
	jupyter-book build fys4220-jbook --builder pdflatex
publish:
	ghp-import -n -p -f -o -r origin fys4220-jbook/_build/html
