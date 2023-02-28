library(vegan)
library(flextable)
patchdata <- read.csv("data4patches.csv")
#extract data for each type of patch into separate variables
earlyforest <- patchdata[1, ]
earlygrassland <- patchdata[2, ]
earlyag <- patchdata[3, ]
lateforest <- patchdata[4, ]
lategrassland <- patchdata[5, ]
lateag <- patchdata[6, ]

#proportions
efpro <- earlyforest$Patches/100
egpro <- earlygrassland$Patches/100
eapro <- earlyag$Patches/100
lfpro <- lateforest$Patches/100
lgpro <- lategrassland$Patches/100
lapro <- lateag$Patches/100

#total patches in each landscape by type
ef <- earlyforest$Patches
eg <- earlygrassland$Patches
ea <- earlyag$Patches
lf <- lateforest$Patches
lg <- lategrassland$Patches
la <- lateag$Patches

#mean area for each patch type = total cells/# of patches
mef <- earlyforest$Cells/earlyforest$Patches
meg <- earlygrassland$Cells/earlygrassland$Patches
mea <- earlyag$Cells/earlyag$Patches
mlf <- lateforest$Cells/lateforest$Patches
mlg <- lategrassland$Cells/lategrassland$Patches
mla <- lateag$Cells/lateag$Patches

#Edge to area ratio for patches
#total edge length of type/total area of type
edgeef <- earlyforest$Edges/earlyforest$Cells
edgeeg <- earlygrassland$Edges/earlygrassland$Cells
edgeea <- earlyag$Edges/earlyag$Cells
edgelf <- lateforest$Edges/lateforest$Cells
edgelg <- lategrassland$Edges/lategrassland$Cells
edgela <- lateag$Edges/lateag$Cells

#Total patch number for the landscape 
#= count of patches for all types using the 4-cell rule 
totalpatchesearly <- (earlyforest$Patches + earlygrassland$Patches + earlyag$Patches)
totalpatcheslate <- (lateforest$Patches + lategrassland$Patches + lateag$Patches)

#2. Shannon-Wiener Diversity Index for the landscape 
#= -Σ [pi * ln(pi)] where pi = the proportion if the ith type 

#first create vectors of proportions for the early and late landscapes
propearly <- c(efpro, egpro, eapro)
proplate <- c(lfpro, lgpro, lapro)

#create a function that calculates the diversity index
SWDI <- function(vars) {
  n = vars
  N = sum(vars)
  p = n/N
  swd = -sum(p*log(p))
  return(swd)
}

#use the function you just created to calculate SWDI for each landscape
earlySWD <- SWDI(propearly)
lateSWD <- SWDI(proplate)
#check function with vegan to make sure it works (edit: it does, so I commented out the command)
#edi = diversity(propearly, 'shannon')

#3. Shannon-Wiener Evenness Index for the landscape. 
#= (-Σ [pi * ln(pi)]) / ln(S) where S = the number of cover types in the 
#landscape 

#use the SWDI function you just made as the basis, so you just need to divide it by the log of then number
#of cover types, in this case there are 3 in each landscape
earlySWE <- earlySWD/log(3)
lateSWE <- lateSWD/log(3)
#alternatively, you can call the length of the vector of the proportions to make it less static in case
#the number of variables changes
earlySWE2 <- earlySWD/log(length(propearly))
lateSWE2 <- lateSWD/log(length(proplate))

#now create the data frames for the two tables
PatchType <- c('Proportion of Landscape', 'Number of Patches', 'Mean Patch Size', 'Edge-to-Area Ratio')
Early_Forest <- c(efpro, ef, mef, edgeef)
Early_Grassland <- c(egpro, eg, meg, edgeeg)
Early_Agriculture <- c(eapro, ea, mea, edgeea)
Late_Forest <- c(lfpro, lf, mlf, edgelf)
Late_Grassland <- c(lgpro, lg, mlg, edgelg)
Late_Agriculture <- c(lapro, la, mla, edgela)
PatchMetrics <- data.frame(PatchType, Early_Forest, Early_Grassland, Early_Agriculture, Late_Forest, Late_Grassland, Late_Agriculture)

LandscapeMetric <- c('Number of Patches', 'Shannon-Wiener Diversity Index', 'Shannon-Wiender Evenness Index')
Early_Settlement <- c(totalpatchesearly, earlySWD, earlySWE)
Late_Settlement <- c(totalpatcheslate, lateSWD, lateSWE)
LandscapeMetrics <- data.frame(LandscapeMetric, Early_Settlement, Late_Settlement)

#tables for the report
pm <- flextable(PatchMetrics)
pm <- add_header_row(pm, top = TRUE, 
                     values = c("Early Settlement", "Late Settlement"), 
                     colwidths = c(4, 3))
pm_1 <- autofit(pm, add_w = 0, add_h = 0)
theme_vanilla(pm_1)

lms <- flextable(LandscapeMetrics)
lm_1 <- autofit(lms, add_w = 0, add_h = 0)
theme_vanilla(lm_1)
