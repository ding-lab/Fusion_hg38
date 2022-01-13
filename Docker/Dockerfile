FROM conda/miniconda3
COPY . /tmp
WORKDIR /tmp
RUN conda env create -f Fusion_hg38_v2.6.yml
## Copies script.py file in my current directory to root in the container
COPY combine_call.pl /
COPY copy_Fusions.sh /
COPY makeDir_v3_normal_only.py /
COPY makeDir_v3_tumor_only.py /
COPY normalFilter.py /
COPY filter.pl /
