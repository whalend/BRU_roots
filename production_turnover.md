Root production and turnover
================

-   [Calculating Estimates of Root Production and
    Turnover](#calculating-estimates-of-root-production-and-turnover)
-   [Production and loss (change) of individual
    roots](#production-and-loss-change-of-individual-roots)
    -   [Sanity Check](#sanity-check)
-   [Modeling](#modeling)
    -   [Gross change](#gross-change)
    -   [Living roots (production)](#living-roots-production)
    -   [Root measurements aggregated to measurement depth
        (“Location”)](#root-measurements-aggregated-to-measurement-depth-location)
        -   [Models for roots measures aggregated to each
            depth](#models-for-roots-measures-aggregated-to-each-depth)
        -   [Models for roots aggregated to
            tubes](#models-for-roots-aggregated-to-tubes)
    -   [Number of roots across size
        bins](#number-of-roots-across-size-bins)
    -   [Individual roots](#individual-roots)
    -   [Averaged individual root
        measurements](#averaged-individual-root-measurements)

<!-- ## GitHub Documents -->
<!-- This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated. -->

CW: use MR + models to get at dynamic rates with depth, and static cores
to get biomass/length with depth, then propagate them together to get
summed fluxes of production and turnover.

What changes happen in gross production and turnover?

Need to work on flagging zombies & wanderers

# Calculating Estimates of Root Production and Turnover

<!-- Milchunas (2009): "good agreement between pulse-isotope turnover and minirhizotron were obtained when minirhizotron estimates were *calculated from regression of decomposition versus production to equilibrium* and when pulse-isotope turnover estimates were calculated from two-phase life-span  regressions." -->

Turnover = entering decomposition, sloughing of roots (“gone”);
deposition into the soil

-   individual present then gone (restrictive)
-   individual present but lost size (length and/or diameter; use
    volume? mass)

Split turnover into 2 parts

Alive –&gt; Dead = senescence Alive or Dead –&gt; Gone = turnover
(decomposition)

Alive to gone = senescence + turnover? (but wanderers)

or

Force “dead” before it can be “gone” for turnover definition? Stronger
confidence that it is truly gone into decomposition and turnover rather
than wanderer.

We can infer that “Gone” roots reappearing as “Alive” later were “Alive”
in between observations, but what about the hidden wanderers, those that
haven’t reappeared yet? (Have yet to take any action related to this;
all observations are treated as-is)

Rate/ratio of alive to dead at time t or time t to time t-1

Rate of production of “alive” roots

***New production & new loss for each root, then aggregate to the
frame***

Calculate gross change for individual roots in length, diameter, and
volume between each time step, for alive, dead, gone. The change values
can then be aggregated to the depth window.

-   flag completely new and totally gone?

Balogianni et al. (2016): “**Root production** was defined as the sum of
the length of new roots formed and any increase in length of existing
roots since the previous sampling day (Johnson et al. 2001). **Root
mortality** was defined as the sum of the length of roots that had
disappeared and any decrease in length of existing roots since the
previous sampling day. Root production and mortality for each interval
was expressed as the average meters of root length that appeared or
disappeared per square meter image area per day (m m−2 days−1) in each
tube.”

Number of new root IDs since initiation in April

April roots: 5409

New roots: 8916

That’s more new root IDs than I thought there would be.

<!-- ## Analyzing individual roots -->
<!-- Rate of appearance in dead and gone column of individual roots -->
<!-- Individual roots days to senescence (dead) or turnover (gone) -->
<!-- Kaplan-Meier or Cox proportional hazard regression -->
<!-- - days to event (senescence or turnover) for individual roots -->
<!-- - 30-day step -->
<!-- Kaplan-Meier: estimate median survivorship/longevity of individual or cohort. "Censoring" for alive/dead - roots still alive at end of period results in underestimates longevity. -->
<!-- Cox: estimate "death hazard" at any given time in relation to other covariates -->

1.  Length, Diameter, Production, Turnover by Depth

2.  Length, Diameter, Production, Turnover by Day of Year (Month)

<!-- Size (diameter) & depth biplot of days to senescence -->

# Production and loss (change) of individual roots

Calculate gross change for individual roots in length, diameter, and
volume between each time step, for alive, dead, gone. The change values
can then be aggregated to the depth window.

<!-- CW: I think the main change is that we need to separate out the gains and losses. So, ind_gain_sum should actually be split into gross gain and gross loss. Then, the next step is to add new roots into the gross gain, and add newly dead or gone roots to the gross loss. -->
<!-- After doing that, we aggregate to each depth window, but now have gross production and gross turnover by window. -->
<!-- Is "gross loss" then the sum of 'Dead', 'Gone' and negative values of 'Alive'? -->

**Gross Gain** = growth of existing roots + new roots

**Gross Loss** = loss of existing roots + dead roots + gone roots

    ##       Tube         Location         Month            name          
    ##  Min.   : 1.0   Min.   : 1.00   Min.   : 5.000   Length:16252      
    ##  1st Qu.: 7.0   1st Qu.:10.00   1st Qu.: 6.000   Class :character  
    ##  Median :12.0   Median :21.00   Median : 8.000   Mode  :character  
    ##  Mean   :12.4   Mean   :21.39   Mean   : 8.039                     
    ##  3rd Qu.:18.0   3rd Qu.:32.00   3rd Qu.:10.000                     
    ##  Max.   :24.0   Max.   :44.00   Max.   :11.000                     
    ##   treatment          root_growth         new_roots           gross_gain      
    ##  Length:16252       Min.   : 0.00000   Min.   :  0.00000   Min.   :  0.0000  
    ##  Class :character   1st Qu.: 0.00000   1st Qu.:  0.00000   1st Qu.:  0.0327  
    ##  Mode  :character   Median : 0.04447   Median :  0.04245   Median :  0.3885  
    ##                     Mean   : 1.20122   Mean   :  2.21664   Mean   :  3.4179  
    ##                     3rd Qu.: 0.61790   3rd Qu.:  0.82409   3rd Qu.:  2.0940  
    ##                     Max.   :55.05780   Max.   :191.70910   Max.   :195.5022

    ##       Tube          Location         Month            name          
    ##  Min.   : 1.00   Min.   : 1.00   Min.   : 5.000   Length:11631      
    ##  1st Qu.: 7.00   1st Qu.: 8.00   1st Qu.: 6.000   Class :character  
    ##  Median :12.00   Median :19.00   Median : 8.000   Mode  :character  
    ##  Mean   :12.57   Mean   :19.82   Mean   : 7.988                     
    ##  3rd Qu.:18.00   3rd Qu.:30.00   3rd Qu.:10.000                     
    ##  Max.   :24.00   Max.   :44.00   Max.   :11.000                     
    ##   treatment            dg_roots         root_loss         gross_loss      
    ##  Length:11631       Min.   : 0.0012   Min.   : 0.0000   Min.   :  0.0012  
    ##  Class :character   1st Qu.: 0.2394   1st Qu.: 0.0000   1st Qu.:  0.3794  
    ##  Mode  :character   Median : 0.6838   Median : 0.1005   Median :  1.0077  
    ##                     Mean   : 3.2679   Mean   : 1.8155   Mean   :  5.0834  
    ##                     3rd Qu.: 2.7424   3rd Qu.: 1.2393   3rd Qu.:  5.2317  
    ##                     Max.   :94.6837   Max.   :63.2020   Max.   :140.3168

Figure of gross gain and gross loss aggregated to depth window.

![](production_turnover_files/figure-gfm/plot_root_change-1.png)<!-- -->

Compare calculated gross change (gain - loss) from T<sub>1</sub> to
T<sub>2</sub> to the observed total at T<sub>2</sub> of root length for
each window.

### Sanity Check

    ## # A tibble: 7,485 x 8
    ##     Tube Location Month treatment TotLength_mm gross_gain gross_loss calc_net
    ##    <dbl>    <dbl> <dbl> <chr>            <dbl>      <dbl>      <dbl>    <dbl>
    ##  1     1        1     4 control           23.2      NA         NA        NA  
    ##  2     1        1     5 control           11.3      NA         NA        NA  
    ##  3     1        1     6 control           62.3      37.7        1.78     47.2
    ##  4     1        1     7 control           76.2      37.9       24.0      76.2
    ##  5     1        1     8 control           67.1       9.61      13.8      72.1
    ##  6     1        1     9 control           36.6      11.6       53.6      25.2
    ##  7     1        1    10 control           65.6       9.52      23.3      22.8
    ##  8     1        1    11 control           77.7      18.6        6.40     77.7
    ##  9     1        2     4 control           27.0      NA         NA        NA  
    ## 10     1        2     5 control           54.0      42.8       15.7      54.0
    ## # … with 7,475 more rows

![](production_turnover_files/figure-gfm/sanity%20check%20gain%20loss-1.png)<!-- -->

    ## [1] 0.9977984

# Modeling

## Gross change

![](production_turnover_files/figure-gfm/model%20gross%20change-1.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: gl_sum ~ clipped + clipped:manure + (1 | Location) + (1 | Tube)
    ##    Data: d
    ## 
    ## REML criterion at convergence: 10162.3
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.3418 -0.6145 -0.1949  0.4957  4.2912 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  Location (Intercept)  275.7   16.60   
    ##  Tube     (Intercept)  743.7   27.27   
    ##  Residual             1237.5   35.18   
    ## Number of obs: 1007, groups:  Location, 44; Tube, 24
    ## 
    ## Fixed effects:
    ##                      Estimate Std. Error t value
    ## (Intercept)           44.8500    10.1518   4.418
    ## clippedyes            -5.0984    13.9091  -0.367
    ## clippedyes:manureyes   0.8722    13.9000   0.063
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) clppdy
    ## clippedyes  -0.685       
    ## clppdys:mnr  0.000 -0.500
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: gg_sum ~ clipped + clipped:manure + (1 | Location) + (1 | Tube)
    ##    Data: d
    ## 
    ## REML criterion at convergence: 10207.8
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8898 -0.6181 -0.1600  0.4757  5.2847 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  Location (Intercept)  236.3   15.37   
    ##  Tube     (Intercept)  933.7   30.56   
    ##  Residual             1299.6   36.05   
    ## Number of obs: 1007, groups:  Location, 44; Tube, 24
    ## 
    ## Fixed effects:
    ##                      Estimate Std. Error t value
    ## (Intercept)            54.897     11.230   4.888
    ## clippedyes             -8.502     15.536  -0.547
    ## clippedyes:manureyes   -2.107     15.527  -0.136
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) clppdy
    ## clippedyes  -0.692       
    ## clppdys:mnr  0.000 -0.500
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/model%20gross%20change-2.png)<!-- -->

## Living roots (production)

Our goal here is to grab at the “low-hanging fruit” using mixed-effects
regression models to evaluate treatment affects and additional
covariates. The response and explanatory variables are listed below. I
think one open question as we go through iterations of model development
is when to apply the (relative) depth as a continous explanatory factor
vs. a random intercept - the answer to this depends on the question
we’re trying to answer.

**Response variables - living roots**

-   (Average) length
-   (Average) volume
-   (Average) diameter

Finest resolution is individual roots. Aggregate (average) response
variables to:

-   Depth window (plot/tube/depth)
-   Depth class (e.g. 1-5 cm, 6-10 cm, etc.)
-   Tube (plot/tube)
-   Plot (plot)

**Explanatory covariates**

Plot level

-   Treatment (uncut, cut, cut + manure)
-   Composition (bahia, mixed)
-   LAI (leaf area index)
-   Soil moisture (VWC)
-   Soil temperature
-   Aboveground biomass
-   Sample month

Random effects (intercepts)

-   (1\|depth)
-   (1\|tube)
-   (1\|month/depth)

## Root measurements aggregated to measurement depth (“Location”)

The sum of each metric was calculated at each combination of Tube,
Location (depth), Month & Date (equivalent but keeping Date handy), and
root\_status.

In the plots, points are the sum values and lines are the fit from
`geom_smooth(method = 'gam', formula = 'y ~ s(x, bs="cs)')`.

We have totals for:

-   root length (mm)
-   projected area (mm2)
-   surface area (mm2)
-   average diameter (cm)
-   volume (mm3)

Depth is roughly 1 cm sections (1 cm x 1 cm minirhizotron image
windows).

![](production_turnover_files/figure-gfm/total_root_length_depth_month-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_avg_diam-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_volume-1.png)<!-- -->

<!-- Are these surface area estimates of current interest? -->
<!-- I don't even know what "proj_area" is -->

### Models for roots measures aggregated to each depth

Depth is the observation unit.

I calculate maximum temperature, minimum temperature, and average
temperature for each month, so these metrics only roughly correspond to
the time around when the root images were taken. Ideally these
temperature values would be for the temperatures recorded between the t
and t-1 measurements (I’m being a little lazy on the first pass).

I do fit and compare separate models for the max, min, and average.
Hopefully I was consistent so that models with “d1” = max temp, “d2” =
min temp, and “d3” = avg temp.

The model pseudocode is:

`lmer(root metric ~ temperature metric + avg_vwc + clipped + clipped:manure + composition + (1 | depth) + (1 | Tube) + (1 | month_num), data = depth_model_data)`

<!-- #### Average root length  -->
<!-- Scratch this -->
<!-- All interpretations with a grain of salt given the less than ideal model diagnostic plots. -->
<!-- Some treatment effect from clipping and simulated grazing (clipping + manure) - clipping alone has shorter while simulated grazing has longer. -->

#### Summed root length

    ##            df      AIC
    ## len_tot_d1 10 70475.47
    ## len_tot_d2 10 70475.13
    ## len_tot_d3 10 70476.15

![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: tot_length_mm ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: 70455.5
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.8396 -0.6572 -0.1552  0.5157  6.3507 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  22.59    4.753  
    ##  Tube      (Intercept) 298.47   17.276  
    ##  month_num (Intercept)  23.49    4.846  
    ##  Residual              698.56   26.430  
    ## Number of obs: 7485, groups:  depth, 44; Tube, 24; month_num, 8
    ## 
    ## Fixed effects:
    ##                      Estimate Std. Error t value
    ## (Intercept)           67.1939    18.6011   3.612
    ## max_temp              -0.8994     0.6496  -1.384
    ## avg_vwc                0.1160     0.1869   0.621
    ## clippedyes            -6.6011     8.6770  -0.761
    ## compositionmixed     -10.1480     7.0909  -1.431
    ## clippedyes:manureyes   3.5530     8.6704   0.410
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy cmpstn
    ## max_temp    -0.914                            
    ## avg_vwc     -0.102  0.006                     
    ## clippedyes  -0.205 -0.032  0.010              
    ## compostnmxd -0.240  0.055 -0.005 -0.002       
    ## clppdys:mnr  0.001  0.000 -0.013 -0.500  0.000
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-5.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length-6.png)<!-- -->

#### Average root length model with LAI

Subset of data with no NA values for LAI.

Is LAI confounded with the “clipped” treatment?

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_length_mm ~ max_temp + avg_vwc + avg_lai + composition +  
    ##     (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: 27430.5
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.9605 -0.6404 -0.1846  0.4374  7.8244 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  0.7014  0.8375  
    ##  Tube      (Intercept)  0.7331  0.8562  
    ##  month_num (Intercept)  0.0000  0.0000  
    ##  Residual              18.6013  4.3129  
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                   Estimate Std. Error t value
    ## (Intercept)       7.586437   0.959829   7.904
    ## max_temp         -0.011956   0.035427  -0.337
    ## avg_vwc           0.001429   0.008009   0.178
    ## avg_lai           0.051306   0.082140   0.625
    ## compositionmixed -0.087212   0.379167  -0.230
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.938                     
    ## avg_vwc     -0.162  0.122              
    ## avg_lai      0.121 -0.272 -0.289       
    ## compostnmxd -0.253  0.094  0.055 -0.195
    ## optimizer (nloptwrap) convergence code: 0 (OK)
    ## boundary (singular) fit: see ?isSingular

![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-4.png)<!-- -->

No effect of LAI.

#### Summed root length model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: tot_length_mm ~ max_temp + avg_vwc + avg_lai + composition +  
    ##     (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: 44257.1
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -4.2137 -0.6643 -0.1412  0.5437  5.7516 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  20.62    4.541  
    ##  Tube      (Intercept) 312.53   17.679  
    ##  month_num (Intercept) 101.98   10.098  
    ##  Residual              642.79   25.353  
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                  Estimate Std. Error t value
    ## (Intercept)      119.8844    26.9438   4.449
    ## max_temp          -2.8907     0.9715  -2.976
    ## avg_vwc            0.2700     0.3003   0.899
    ## avg_lai           -2.0620     0.7376  -2.796
    ## compositionmixed -11.3516     7.3009  -1.555
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.957                     
    ## avg_vwc     -0.170  0.044              
    ## avg_lai     -0.078  0.011  0.101       
    ## compostnmxd -0.196  0.071 -0.012 -0.085

![](production_turnover_files/figure-gfm/depth%20summed%20root%20length%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20length%20LAI-4.png)<!-- -->

Pretty strong negative relationship with LAI and maximum temperature.

#### Average root diameter

    ##             df       AIC
    ## diam_avg_d1 10 -14010.24
    ## diam_avg_d2 10 -14010.10
    ## diam_avg_d3 10 -14009.95

![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_diam_mm ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: -14030.2
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.3192 -0.5786 -0.1667  0.3574 10.8696 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance  Std.Dev.
    ##  depth     (Intercept) 0.0001390 0.01179 
    ##  Tube      (Intercept) 0.0006053 0.02460 
    ##  month_num (Intercept) 0.0001353 0.01163 
    ##  Residual              0.0087492 0.09354 
    ## Number of obs: 7485, groups:  depth, 44; Tube, 24; month_num, 8
    ## 
    ## Fixed effects:
    ##                        Estimate Std. Error t value
    ## (Intercept)           0.2531006  0.0529380   4.781
    ## max_temp              0.0007478  0.0019674   0.380
    ## avg_vwc               0.0002917  0.0005206   0.560
    ## clippedyes           -0.0109724  0.0126266  -0.869
    ## compositionmixed      0.0362068  0.0103465   3.499
    ## clippedyes:manureyes  0.0012603  0.0125792   0.100
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy cmpstn
    ## max_temp    -0.973                            
    ## avg_vwc     -0.099  0.005                     
    ## clippedyes  -0.056 -0.067  0.020              
    ## compostnmxd -0.207  0.115 -0.009 -0.008       
    ## clppdys:mnr  0.002  0.000 -0.025 -0.499  0.001
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-5.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-6.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter-7.png)<!-- -->

Average root diameter is larger in the mixed versus the bahia only
composition. The scale of these coefficient estimates is super tiny -
100ths of millimeters.

Peanut roots contributing to larger average diameter

#### Average root diameter model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_diam_mm ~ max_temp + avg_vwc + avg_lai + composition + (1 |  
    ##     depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: -9764.1
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.3940 -0.5977 -0.1650  0.3855 11.5469 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance  Std.Dev.
    ##  depth     (Intercept) 0.0001092 0.01045 
    ##  Tube      (Intercept) 0.0006695 0.02588 
    ##  month_num (Intercept) 0.0004129 0.02032 
    ##  Residual              0.0071901 0.08479 
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                    Estimate Std. Error t value
    ## (Intercept)       0.3900039  0.0778263   5.011
    ## max_temp         -0.0048092  0.0028692  -1.676
    ## avg_vwc           0.0004901  0.0008093   0.606
    ## avg_lai          -0.0034153  0.0020101  -1.699
    ## compositionmixed  0.0406241  0.0110821   3.666
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.980                     
    ## avg_vwc     -0.163  0.048              
    ## avg_lai     -0.095  0.041  0.032       
    ## compostnmxd -0.190  0.134 -0.009 -0.147

![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-4.png)<!-- -->

A sort of negative relationship with LAI.

<!-- #### Summed root diameter -->

#### Average root volume

    ##               df      AIC
    ## volume_avg_d3 10 20958.53
    ## volume_avg_d2 10 20958.72
    ## volume_avg_d1 10 20958.75

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_volume_mm3 ~ avg_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: 20938.5
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.3894 -0.5117 -0.2544  0.1668 16.6824 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance  Std.Dev.
    ##  depth     (Intercept) 0.0166390 0.12899 
    ##  Tube      (Intercept) 0.0364258 0.19086 
    ##  month_num (Intercept) 0.0002746 0.01657 
    ##  Residual              0.9413149 0.97021 
    ## Number of obs: 7485, groups:  depth, 44; Tube, 24; month_num, 8
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           0.573624   0.168267   3.409
    ## avg_temp              0.008153   0.005857   1.392
    ## avg_vwc               0.001116   0.001798   0.620
    ## clippedyes           -0.201084   0.099484  -2.021
    ## compositionmixed      0.163308   0.081180   2.012
    ## clippedyes:manureyes  0.130591   0.099198   1.316
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) avg_tm avg_vw clppdy cmpstn
    ## avg_temp    -0.861                            
    ## avg_vwc     -0.072 -0.036                     
    ## clippedyes  -0.282 -0.019  0.013              
    ## compostnmxd -0.273  0.037 -0.006 -0.001       
    ## clppdys:mnr  0.002 -0.001 -0.013 -0.499  0.001
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-5.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-6.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume-7.png)<!-- -->

Lower average volume in clipped but higher average volume in mixed
composition. The mean point estimate for simulated grazing is solidly on
the positive side.

#### Average root volume model with LAI

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-1.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_volume_mm3 ~ avg_temp + avg_vwc + avg_lai + composition +  
    ##     (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: 12849.9
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.2692 -0.5259 -0.2584  0.1877 13.4760 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept) 0.014171 0.11904 
    ##  Tube      (Intercept) 0.047248 0.21737 
    ##  month_num (Intercept) 0.001493 0.03864 
    ##  Residual              0.857380 0.92595 
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                   Estimate Std. Error t value
    ## (Intercept)       0.538682   0.221083   2.437
    ## avg_temp          0.006846   0.008454   0.810
    ## avg_vwc           0.001146   0.002693   0.425
    ## avg_lai          -0.016255   0.019444  -0.836
    ## compositionmixed  0.197473   0.094404   2.092
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) avg_tm avg_vw avg_la
    ## avg_temp    -0.927                     
    ## avg_vwc     -0.151  0.051              
    ## avg_lai      0.046 -0.206 -0.182       
    ## compostnmxd -0.251  0.076  0.029 -0.181

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-5.png)<!-- -->

No effect of LAI.

#### Summed root volume

    ##               df      AIC
    ## volume_tot_d3 10 41587.34
    ## volume_tot_d2 10 41588.31
    ## volume_tot_d1 10 41588.80

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: tot_volume_mm3 ~ avg_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: 41567.3
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.3808 -0.5926 -0.2575  0.3391  9.1964 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  0.46372 0.6810  
    ##  Tube      (Intercept)  2.11558 1.4545  
    ##  month_num (Intercept)  0.03463 0.1861  
    ##  Residual              14.74849 3.8404  
    ## Number of obs: 7485, groups:  depth, 44; Tube, 24; month_num, 8
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           2.284113   1.094178   2.088
    ## avg_temp              0.081501   0.036360   2.241
    ## avg_vwc               0.005945   0.011075   0.537
    ## clippedyes           -1.265276   0.735797  -1.720
    ## compositionmixed     -0.108779   0.600821  -0.181
    ## clippedyes:manureyes  0.652461   0.735137   0.888
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) avg_tm avg_vw clppdy cmpstn
    ## avg_temp    -0.822                            
    ## avg_vwc     -0.071 -0.032                     
    ## clippedyes  -0.325 -0.015  0.009              
    ## compostnmxd -0.301  0.032 -0.005 -0.001       
    ## clppdys:mnr  0.002 -0.001 -0.010 -0.500  0.000
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-3.png)<!-- -->

    ## [[1]]

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-4.png)<!-- -->

    ## 
    ## [[2]]

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-5.png)<!-- -->

    ## 
    ## [[3]]

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-6.png)<!-- -->
![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-7.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: tot_volume_mm3 ~ std2_max_temp + std2_avg_vwc + std2_avg_lai +  
    ##     std2_avg_lai:clipped + clipped + clipped:manure + composition +  
    ##     (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: 26000.9
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.7672 -0.5912 -0.2484  0.3372  9.7096 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  0.3959  0.6292  
    ##  Tube      (Intercept)  2.3652  1.5379  
    ##  month_num (Intercept)  3.4825  1.8662  
    ##  Residual              13.7002  3.7014  
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                         Estimate Std. Error t value
    ## (Intercept)               4.6698     1.1297   4.134
    ## std2_max_temp            -2.0876     0.4788  -4.360
    ## std2_avg_vwc              1.0172     0.6555   1.552
    ## std2_avg_lai             -0.9024     0.7019  -1.286
    ## clippedyes               -2.0508     0.9059  -2.264
    ## compositionmixed         -0.3804     0.6558  -0.580
    ## std2_avg_lai:clippedyes  -0.5195     1.0476  -0.496
    ## clippedyes:manureyes      0.7298     0.7814   0.934
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) std2_m_ std2_vg_v std2_vg_l clppdy cmpstn st2__:
    ## std2_mx_tmp  0.028                                                 
    ## std2_vg_vwc -0.086  0.046                                          
    ## std2_avg_la -0.353 -0.075   0.076                                  
    ## clippedyes  -0.460 -0.068   0.075     0.459                        
    ## compostnmxd -0.202  0.133  -0.023    -0.201    -0.105              
    ## std2_vg_l:c  0.291  0.101  -0.011    -0.809    -0.248  0.144       
    ## clppdys:mnr  0.000 -0.018  -0.049     0.006    -0.436 -0.001 -0.029
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20summed%20root%20volume-8.png)<!-- -->

### Models for roots aggregated to tubes

The MR tube is the observation level.

If I understood the experiment and MR tube setup then each tube is the
same as a plot.

Model pseudo-code:

`lmer(root metric ~ temperature metric + avg_vwc + clipped + clipped:manure + composition + (1|block/Tube) + (1|month_num), data = tube_model_data)`

In coming back to this I noticed I used block in the random effect here
but not in the depth models…

#### Average root length

    ##            df      AIC
    ## len_avg_m1 10 482.6484
    ## len_avg_m3 10 482.7069
    ## len_avg_m2 10 483.3816

![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_length_mm ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_model_data
    ## 
    ## REML criterion at convergence: 462.6
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -6.6513 -0.4218 -0.0024  0.4214  4.2732 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance Std.Dev.
    ##  Tube:block (Intercept) 0.29818  0.5461  
    ##  block      (Intercept) 0.02422  0.1556  
    ##  month_num  (Intercept) 0.43598  0.6603  
    ##  Residual               0.42898  0.6550  
    ## Number of obs: 194, groups:  Tube:block, 24; block, 8; month_num, 8
    ## 
    ## Fixed effects:
    ##                      Estimate Std. Error t value
    ## (Intercept)           5.71336    2.51054   2.276
    ## max_temp              0.02648    0.09434   0.281
    ## avg_vwc               0.03714    0.02627   1.414
    ## clippedyes           -0.80125    0.29946  -2.676
    ## compositionmixed     -0.05450    0.27182  -0.201
    ## clippedyes:manureyes  0.44274    0.29675   1.492
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy cmpstn
    ## max_temp    -0.985                            
    ## avg_vwc     -0.128  0.029                     
    ## clippedyes   0.070 -0.136  0.043              
    ## compostnmxd -0.253  0.206 -0.014 -0.031       
    ## clppdys:mnr  0.008 -0.003 -0.055 -0.495  0.002
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-4.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-5.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-6.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20root%20length-7.png)<!-- -->

Aggregating up to the tube level tidies up the diagnostic plots in most
cases.

Negative effect of clipping - shorter roots.

#### Average root length model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_length_mm ~ max_temp + avg_vwc + avg_lai + composition +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_lai_model_data
    ## 
    ## REML criterion at convergence: 319.4
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -5.8937 -0.3526  0.0745  0.3408  3.8631 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance Std.Dev.
    ##  Tube:block (Intercept) 0.27007  0.5197  
    ##  block      (Intercept) 0.05703  0.2388  
    ##  month_num  (Intercept) 0.00000  0.0000  
    ##  Residual               0.52232  0.7227  
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                   Estimate Std. Error t value
    ## (Intercept)       8.703486   0.974172   8.934
    ## max_temp         -0.084796   0.036071  -2.351
    ## avg_vwc           0.007646   0.008298   0.921
    ## avg_lai           0.149902   0.063098   2.376
    ## compositionmixed -0.244656   0.306761  -0.798
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.966                     
    ## avg_vwc     -0.158  0.097              
    ## avg_lai      0.058 -0.169 -0.225       
    ## compostnmxd -0.218  0.090  0.038 -0.187
    ## optimizer (nloptwrap) convergence code: 0 (OK)
    ## boundary (singular) fit: see ?isSingular

![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-4.png)<!-- -->

Positive relationship between root length and LAI. Negative relationship
with maximum temperature.

<!-- #### Summed root length -->
<!-- #### Summed root length model with LAI -->

#### Average root volume

    ##            df       AIC
    ## vol_avg_m1  9 -66.77159
    ## vol_avg_m3 10 -62.89409
    ## vol_avg_m2 10 -62.27376

![](production_turnover_files/figure-gfm/tube%20avg%20volume-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_volume_mm3 ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_model_data
    ## 
    ## REML criterion at convergence: -84.8
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.7903 -0.4543 -0.0140  0.4139  4.4844 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance Std.Dev.
    ##  Tube:block (Intercept) 0.016820 0.12969 
    ##  block      (Intercept) 0.006110 0.07817 
    ##  month_num  (Intercept) 0.001261 0.03550 
    ##  Residual               0.025082 0.15837 
    ## Number of obs: 194, groups:  Tube:block, 24; block, 8; month_num, 8
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           0.866572   0.276931   3.129
    ## max_temp             -0.004945   0.010418  -0.475
    ## avg_vwc               0.004181   0.002402   1.741
    ## clippedyes           -0.214703   0.070727  -3.036
    ## clippedyes:manureyes  0.104251   0.070583   1.477
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy
    ## max_temp    -0.974                     
    ## avg_vwc     -0.085  0.001              
    ## clippedyes  -0.069 -0.062  0.020       
    ## clppdys:mnr  0.002  0.000 -0.023 -0.498
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/tube%20avg%20volume-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume-4.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume-5.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume-6.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume-7.png)<!-- -->

Negative effect of clipping, positive direction for simulated grazing
and soil moisture (standardized).

#### Average root volume model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_volume_mm3 ~ max_temp + avg_vwc + avg_lai + composition +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_model_data
    ## 
    ## REML criterion at convergence: -35.2
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.7436 -0.4012 -0.0355  0.3573  4.8961 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance  Std.Dev.
    ##  Tube:block (Intercept) 2.564e-02 0.160134
    ##  block      (Intercept) 4.067e-03 0.063770
    ##  month_num  (Intercept) 1.644e-05 0.004054
    ##  Residual               2.399e-02 0.154885
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                   Estimate Std. Error t value
    ## (Intercept)       0.775948   0.214374   3.620
    ## max_temp         -0.007021   0.007879  -0.891
    ## avg_vwc           0.001267   0.001815   0.698
    ## avg_lai           0.011884   0.016615   0.715
    ## compositionmixed  0.118806   0.085642   1.387
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.948                     
    ## avg_vwc     -0.162  0.115              
    ## avg_lai      0.085 -0.220 -0.267       
    ## compostnmxd -0.251  0.084  0.044 -0.178

![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-4.png)<!-- -->

No effect of LAI.

#### Average root diameter

    ##            df       AIC
    ## dia_avg_m1  9 -784.2400
    ## dia_avg_m3 10 -779.6283
    ## dia_avg_m2 10 -778.9379

![](production_turnover_files/figure-gfm/tube%20avg%20diameter-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20diameter-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_diam_mm ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_model_data
    ## 
    ## REML criterion at convergence: -802.2
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.7095 -0.4940  0.0052  0.4937  3.9501 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance  Std.Dev.
    ##  Tube:block (Intercept) 3.985e-04 0.01996 
    ##  block      (Intercept) 4.283e-04 0.02070 
    ##  month_num  (Intercept) 6.906e-05 0.00831 
    ##  Residual               5.347e-04 0.02312 
    ## Number of obs: 194, groups:  Tube:block, 24; block, 8; month_num, 8
    ## 
    ## Fixed effects:
    ##                        Estimate Std. Error t value
    ## (Intercept)           0.2778248  0.0524481   5.297
    ## max_temp              0.0001918  0.0019750   0.097
    ## avg_vwc               0.0001042  0.0004668   0.223
    ## clippedyes           -0.0116728  0.0108141  -1.079
    ## clippedyes:manureyes -0.0007702  0.0107803  -0.071
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy
    ## max_temp    -0.974                     
    ## avg_vwc     -0.086  0.000              
    ## clippedyes  -0.029 -0.078  0.024       
    ## clppdys:mnr  0.003  0.000 -0.028 -0.498
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/tube%20avg%20diameter-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20diameter-4.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20diameter-5.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20diameter-6.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20diameter-7.png)<!-- -->

Maybe a tiny influence of clipping on average root diameter.

#### Average root diameter model with LAI

![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_diam_mm ~ max_temp + avg_vwc + avg_lai + composition + (1 |  
    ##     block/Tube) + (1 | month_num)
    ##    Data: tube_lai_model_data
    ## 
    ## REML criterion at convergence: -512.7
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.1293 -0.3931  0.0217  0.3796  5.3435 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance  Std.Dev.
    ##  Tube:block (Intercept) 0.0003008 0.01734 
    ##  block      (Intercept) 0.0004914 0.02217 
    ##  month_num  (Intercept) 0.0009796 0.03130 
    ##  Residual               0.0003926 0.01982 
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                    Estimate Std. Error t value
    ## (Intercept)       4.798e-01  1.146e-01   4.186
    ## max_temp         -9.086e-03  4.208e-03  -2.159
    ## avg_vwc           1.562e-03  1.170e-03   1.335
    ## avg_lai          -6.559e-05  1.991e-03  -0.033
    ## compositionmixed  3.048e-02  1.776e-02   1.716
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la
    ## max_temp    -0.980                     
    ## avg_vwc     -0.177  0.066              
    ## avg_lai     -0.163  0.132  0.013       
    ## compostnmxd -0.181  0.113 -0.004 -0.080

![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-4.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-5.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-6.png)<!-- -->

Ugly quantiles diagnostic plots. No effect of LAI.

## Number of roots across size bins

<!-- add diameter bins -->

![](production_turnover_files/figure-gfm/bins_length_diam_fig-1.png)<!-- -->![](production_turnover_files/figure-gfm/bins_length_diam_fig-2.png)<!-- -->

![](production_turnover_files/figure-gfm/density_plot_length_diam-1.png)<!-- -->![](production_turnover_files/figure-gfm/density_plot_length_diam-2.png)<!-- -->

## Individual roots

Plotted metrics by depth, month, and status

![](production_turnover_files/figure-gfm/root_length_depth_month-1.png)<!-- -->

![](production_turnover_files/figure-gfm/diameter_depth_month-1.png)<!-- -->

## Averaged individual root measurements

Root length, diameter, and volume by depth, month, and status.

Points are means, blue error bars are standard errors, red are 95% CI.
Both calculated using `stat_summary()` implementation. The line is the
fit from `geom_smooth(method = 'gam', formula = 'y ~ s(x, bs="cs)')`,
the default action in this case.

<!-- Add figure of medians, mode, explore using standard deviation -->

![](production_turnover_files/figure-gfm/avg_length_depth_month-1.png)<!-- -->

![](production_turnover_files/figure-gfm/avg_diam_depth_month-1.png)<!-- -->

![](production_turnover_files/figure-gfm/avg_volume_depth_month-1.png)<!-- -->
