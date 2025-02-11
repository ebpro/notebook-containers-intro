#!/bin/bash
source /opt/conda/bin/activate base
tlmgr option repository http://ctan.tetaneutral.net/systems/texlive/tlnet
quarto render $@ --execute
quarto render $@ --profile slides 
