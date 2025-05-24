#perl syntenyTool.pl -t mcscanx_block -c ../cs10_mcscanx_ctgmap.txt ../cs10/cs10.collinearity  ../cs10/cs10.gff  > cs10.block
perl syntenyTool.pl -t mcscanx_block -c ../pkv5_mcscanx_ctgmap.txt ../pkv5/pkv5.collinearity  ../pkv5/pkv5.gff  > pkv5.block
perl syntenyTool.pl -t mcscanx_block -c ../cs10_pkv5_mcscanx_ctgmap.txt ../cs10vspkv5/cs10vspkv5.collinearity  ../cs10vspkv5/cs10vspkv5.gff  > cs10vspkv5.block
perl syntenyTool.pl -t mcscanx_block -c ../cs10_pkv5_mcscanx_ctgmap.txt ../pkv5vscs10/pkv5vscs10.collinearity  ../pkv5vscs10/pkv5vscs10.gff  > pkv5vscs10.block
