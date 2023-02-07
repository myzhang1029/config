# Use XeLaTeX by default
$pdf_mode = 5;
# Enable synctex
set_tex_cmds('-synctex=1 %O %S');
# Clean up extra auxiliary files
$clean_ext = "run.xml synctex.gz bbl";
