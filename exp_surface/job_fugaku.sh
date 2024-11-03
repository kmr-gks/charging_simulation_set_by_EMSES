#!/bin/bash
#PJM -L  "node=3"            # 割当ノード
#PJM --mpi proc=128          # MPIプロセス数
#PJM -L  "rscgrp=small"      # リソースグループの指定
#PJM -L  "elapse=10:00:00"   # 経過時間制限
#PJM -x PJM_LLIO_GFSCACHE=/vol0004 #spackを使うとき指定
#PJM -g hp240400

#モジュールロードに使用
. /vol0004/apps/oss/spack/share/spack/setup-env.sh
#hdf5,fftwモジュールをロード
spack load /yhazdvl
spack load /upvlzyl

#https://www.fugaku.r-ccs.riken.jp/doc_root/ja/user_guides/FugakuSpackGuide/intro.html#os
#OS標準の動的ライブラリパスが上書きされる問題
export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH

export EMSES_DEBUG=no

date

rm *_0000.h5
mpiexec ./mpiemses3D plasma.inp

date

echo "Postprocessing(visualization code, etc.)"

echo ...done

python generate_xdmf3.py nd*.h5 rhobk00_0000.h5
python generate_xdmf3.py rho00_0000.h5
python generate_xdmf3.py phisp00_0000.h5
python generate_xdmf3.py ex00_0000.h5 ey00_0000.h5 ez00_0000.h5
python generate_xdmf3.py j1x00_0000.h5 j1y00_0000.h5 j1z00_0000.h5 j2x00_0000.h5 j2y00_0000.h5 j2z00_0000.h5 j3x00_0000.h5 j3y00_0000.h5 j3z00_0000.h5
date
