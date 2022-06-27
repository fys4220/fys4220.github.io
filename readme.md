# FYS4220 webpage

This is the Jupyter-book source code for the FYS4220 webpage.

Requirements:
- Sphinxs extensions
    - pip install sphinxcontrib-mermaid
        - mermaid-cli needed for latex output: brew install mermaid-cli
    - pip install sphinxcontrib-wavedrom



### Graphics
Decided to generate all Mermaid graphics to files and include as figure in order to use figure numbering and caption. Was not able to figure out how to add this for inline Mermaid script.

There is a problem converting from Mermaid script to SVG files if script contains line breaks (```<br>, <br/>, \n```). Using pdf instead, as this also is supported for Latex output (not supporting svg).

```
mmdc -i mermaid.mmd -o mermaid.pdf -f 100
````



## Progress
- Design units
    - Ex: button/sw to LED (single)
- Objexts and data types
    - ex: sw to LED (vector)
- Operators:
    - ex: adder? MV? 
- Description styles:
    - ex: MV as 

