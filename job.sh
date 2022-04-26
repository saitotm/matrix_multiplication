#!/bin/bash
#YBATCH -r any_1
#SBATCH -N 1
#SBATCH -J matrix_multiplication
#SBATCH --time=00:10:00

. /etc/profile.d/modules.sh
module load cuda

./build/main

