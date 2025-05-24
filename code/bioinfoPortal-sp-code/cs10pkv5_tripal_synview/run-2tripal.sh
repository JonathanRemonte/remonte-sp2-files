#perl syntenyTool.pl -t mcscanx_tripal -a cs -b pk -c 1 -d 2 ../cs10_pkv5_mcscanx_ctgmap.txt ../cs10_pkv5_mcscanx_in.origname.gff ../cs10_pkv5/cs10_pkv5.collinearity.origname cs10_pkv5_mcscanx.block.clean2 > cs10_pkv5_mcscanx.block.clean2.tripal.txt
#perl syntenyTool.pl -t mcscanx_tripal -a pk  -b cs -c 2 -d 1 ../cs10_pkv5_mcscanx_ctgmap.txt ../cs10_pkv5_mcscanx_in.origname.gff ../cs10_pkv5/cs10_pkv5.collinearity.origname cs10_pkv5_mcscanx.block.clean > cs10_pkv5_mcscanx.block.clean-rev.tripal.txt


perl syntenyTool.pl -t mcscanx_tripal -a pk  -b cs -c 2 -d 1 ../cs10_pkv5_mcscanx_ctgmap.txt ../cs10_pkv5_mcscanx_in.origname.gff ../pkv5vscs10/pkv5vscs10.collinearity.origname pkv5vscs10.block > pkv5vscs10_mcscanx.block.tripal.txt
perl syntenyTool.pl -t mcscanx_tripal -a pk  -b pk -c 2 -d 2 ../pkv5_mcscanx_ctgmap.txt ../pkv5_mcscanx_in.origname.gff ../pkv5/pkv5.collinearity.origname pkv5.block > pkv5_mcscanx.block.tripal.txt
perl syntenyTool.pl -t mcscanx_tripal -a cs  -b cs -c 1 -d 1 ../cs10_mcscanx_ctgmap.txt ../cs10_mcscanx_in.origname.gff ../cs10/cs10.collinearity cs10.block > cs10_mcscanx.block.tripal.txt
perl syntenyTool.pl -t mcscanx_tripal -a cs  -b pk -c 1 -d 2 ../cs10_pkv5_mcscanx_ctgmap.txt ../cs10_pkv5_mcscanx_in.origname.gff ../cs10vspkv5/cs10vspkv5.collinearity.origname cs10vspkv5.block > cs10vspkv5_mcscanx.block.tripal.txt





