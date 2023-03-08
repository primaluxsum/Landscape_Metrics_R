# Landscape_Metrics_R
R Script for Calculating Landscape Metrics
by Marie Cerda, 2023. Written for an assignment in Landscape Ecology, REM 429, at the University of Idaho.

This is a simple R script to caculate a series of landscape metrics from existing data stored in .csv format

The .csv file contains data for a single landscape, categorized by dominant cover type, in subclasses based on successional stage (early and late).
The data is divided into columns listing the number of patches of each cover class, the number of "cells" total for each cover type, and
the number of edges found for each cover type. Edges are a single side of a single cell, so a single cell patch of a given
over type will have 4 edges if it does not touch a patch of the same cover type on any of the 4 edges. Patches are defined using the 4-neighbor
rule. This landscape data is from theoretical landscapes but can be counted from real landscapes using quadrats or by over-laying grids
on remotely-sensed imagery. The metrics can be used to compare cover types and landscape stages over time. 
Data in the .csv file is divided into four columns: Cover type, number of patches, number of cells, number of edges.

The metrics calculated in this script are as follows:
1)Proportion of the landscape covered by cover type x
2)total patches in the landscape of each cover type x
3)the mean area for each patch type, calculated as the total number of cells of cover type x / the total number of cells in the landscape
4)the edge to area ratio for each cove type, defined as the total edge length of type x / total area of type x
5)the total number of patches for each successional stage, total number of patches in early stage, total number of patches in late stage
6)Shannon Weiner Diversity Index for each stage in the landscape, calculation for this metric is -Σ [px * ln(px)] where pi = the proportion if the xth cover type 
7)Shannon-Wiener Evenness Index for each stage in the landscape, calculation is (-Σ [px * ln(px)]) / ln(S) where S = the number of cover types in the landscape 

Metrics and calculation information is also commented in the R script.

The script also creates a table of these metrics that can be used in reports or papers.

The script calls two packages - vegan and flextable - but neither are required for the calculation of the metrics. Vegan is a script that can calculate SWDI and I 
used it to check my calculations, but I left it in in case some people prefer to do the calculation that way, rather than by using my script, or if they would like
to check the calculations. The lines are commented out, but can easily be uncommented (and the function I wrote to calculate SWDI can be commented out, though that
will require some minor adjustments for the SWEI calculations). 
Flextable is used to construct the table solely for aesthetic and customization reasons. It is not required for any of the calculations.
Ultimately this is a standalone script that only requires a .csv file containing the associated data, but it is highly customizable and can easily be changed to
fit the needs of the project.

If this is a script I continue to use and alter, future revisions will likely include streamlining the data by dividing it into stage subclasses in the data file rather than
indicating successional stage in the name of the patch type and making the necessary adjustments in the script.
