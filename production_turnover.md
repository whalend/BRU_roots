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

#### Average root length

    ##            df      AIC
    ## len_avg_d1 10 42847.78
    ## len_avg_d3 10 42848.30
    ## len_avg_d2 10 42848.79

![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_length_mm ~ max_temp + avg_vwc + clipped + clipped:manure +  
    ##     composition + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_model_data
    ## 
    ## REML criterion at convergence: 42827.8
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.0533 -0.6239 -0.1907  0.4063  8.7353 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  0.7353  0.8575  
    ##  Tube      (Intercept)  0.6164  0.7851  
    ##  month_num (Intercept)  0.3338  0.5777  
    ##  Residual              17.4713  4.1799  
    ## Number of obs: 7485, groups:  depth, 44; Tube, 24; month_num, 8
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           5.272250   2.444548   2.157
    ## max_temp              0.067016   0.091551   0.732
    ## avg_vwc               0.020440   0.024769   0.825
    ## clippedyes           -0.750869   0.412820  -1.819
    ## compositionmixed      0.004467   0.339541   0.013
    ## clippedyes:manureyes  0.794943   0.409788   1.940
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw clppdy cmpstn
    ## max_temp    -0.981                            
    ## avg_vwc     -0.108  0.011                     
    ## clippedyes   0.007 -0.096  0.029              
    ## compostnmxd -0.226  0.163 -0.012 -0.016       
    ## clppdys:mnr  0.003  0.001 -0.037 -0.497  0.002
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-5.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-6.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length-7.png)<!-- -->

#### Average root length model with LAI

Subset of data with no NA values for LAI.

Is LAI confounded with the “clipped” treatment?

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: 
    ## avg_length_mm ~ max_temp + avg_vwc + avg_lai + clipped + clipped:manure +  
    ##     composition + avg_lai + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: 27424.8
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.9522 -0.6396 -0.1869  0.4408  7.8216 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept)  0.6994  0.8363  
    ##  Tube      (Intercept)  0.6188  0.7866  
    ##  month_num (Intercept)  0.0000  0.0000  
    ##  Residual              18.6027  4.3131  
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           7.732581   0.976962   7.915
    ## max_temp             -0.004289   0.037096  -0.116
    ## avg_vwc               0.002821   0.008341   0.338
    ## avg_lai              -0.008180   0.117453  -0.070
    ## clippedyes           -0.831267   0.593703  -1.400
    ## compositionmixed     -0.032332   0.361284  -0.089
    ## clippedyes:manureyes  0.924848   0.421859   2.192
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la clppdy cmpstn
    ## max_temp    -0.810                                   
    ## avg_vwc     -0.086  0.195                            
    ## avg_lai     -0.087 -0.394 -0.394                     
    ## clippedyes  -0.203 -0.290 -0.269  0.701              
    ## compostnmxd -0.183  0.157  0.115 -0.294 -0.207       
    ## clppdys:mnr  0.009  0.011  0.001 -0.039 -0.383  0.012
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient
    ## optimizer (nloptwrap) convergence code: 0 (OK)
    ## boundary (singular) fit: see ?isSingular

![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20length%20LAI-4.png)<!-- -->

<!-- #### Summed root length -->

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

#### Average root diameter model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: 
    ## avg_diam_mm ~ max_temp + avg_vwc + avg_lai + clipped + clipped:manure +  
    ##     composition + avg_lai + (1 | depth) + (1 | Tube) + (1 | month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: -9756.9
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.4457 -0.5952 -0.1674  0.3857 11.5301 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance  Std.Dev.
    ##  depth     (Intercept) 0.0001092 0.01045 
    ##  Tube      (Intercept) 0.0005271 0.02296 
    ##  month_num (Intercept) 0.0003514 0.01875 
    ##  Residual              0.0071912 0.08480 
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                        Estimate Std. Error t value
    ## (Intercept)           0.3938085  0.0757925   5.196
    ## max_temp             -0.0037211  0.0027963  -1.331
    ## avg_vwc               0.0003658  0.0007747   0.472
    ## avg_lai              -0.0072587  0.0024824  -2.924
    ## clippedyes           -0.0389080  0.0147909  -2.631
    ## compositionmixed      0.0444821  0.0100373   4.432
    ## clippedyes:manureyes  0.0075093  0.0118842   0.632
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la clppdy cmpstn
    ## max_temp    -0.968                                   
    ## avg_vwc     -0.163  0.047                            
    ## avg_lai     -0.131 -0.013  0.031                     
    ## clippedyes  -0.089 -0.065  0.041  0.592              
    ## compostnmxd -0.179  0.154 -0.011 -0.210 -0.134       
    ## clppdys:mnr  0.028 -0.017 -0.052 -0.036 -0.423  0.006
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20diameter%20with%20LAI-4.png)<!-- -->

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

#### Average root volume model with LAI

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-1.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: avg_volume_mm3 ~ avg_temp + avg_vwc + avg_lai + composition +  
    ##     clipped + clipped:manure + (1 | depth) + (1 | Tube) + (1 |      month_num)
    ##    Data: depth_lai_model_data
    ## 
    ## REML criterion at convergence: 12842.5
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.2612 -0.5264 -0.2595  0.1965 13.4663 
    ## 
    ## Random effects:
    ##  Groups    Name        Variance Std.Dev.
    ##  depth     (Intercept) 0.014138 0.11890 
    ##  Tube      (Intercept) 0.031006 0.17609 
    ##  month_num (Intercept) 0.001886 0.04342 
    ##  Residual              0.856850 0.92566 
    ## Number of obs: 4738, groups:  depth, 44; Tube, 24; month_num, 5
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           0.756602   0.242429   3.121
    ## avg_temp              0.011975   0.009215   1.300
    ## avg_vwc               0.002512   0.002914   0.862
    ## avg_lai              -0.069169   0.025863  -2.674
    ## compositionmixed      0.244455   0.080208   3.048
    ## clippedyes           -0.484522   0.131060  -3.697
    ## clippedyes:manureyes  0.202467   0.093956   2.155
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) avg_tm avg_vw avg_la cmpstn clppdy
    ## avg_temp    -0.836                                   
    ## avg_vwc     -0.101  0.071                            
    ## avg_lai     -0.181 -0.261 -0.219                     
    ## compostnmxd -0.145  0.123  0.058 -0.284              
    ## clippedyes  -0.258 -0.191 -0.141  0.695 -0.198       
    ## clppdys:mnr  0.018  0.002 -0.015 -0.039  0.011 -0.386
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-4.png)<!-- -->![](production_turnover_files/figure-gfm/depth%20avg%20root%20volume%20with%20LAI-5.png)<!-- -->

<!-- #### Summed root volume -->

### Models for roots aggregated to tubes

The MR tube is the observation level.

If I understood the experiment and MR tube setup then each tube is the
same as a plot.

Model pseudo-code:

`lmer(root metric ~ temperature metric + avg_vwc + clipped + clipped:manure + composition + (1|block/Tube) + (1|month_num), data = tube_model_data)`

In coming back to this I noticed I used block in the random effect here
but not in the depth models

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

#### Average root length model with LAI

![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: 
    ## avg_length_mm ~ max_temp + avg_vwc + avg_lai + clipped + clipped:manure +  
    ##     composition + (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_lai_model_data
    ## 
    ## REML criterion at convergence: 314.1
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -6.0300 -0.3742  0.1175  0.3593  3.7379 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance Std.Dev.
    ##  Tube:block (Intercept) 0.23170  0.4813  
    ##  block      (Intercept) 0.03669  0.1915  
    ##  month_num  (Intercept) 0.00000  0.0000  
    ##  Residual               0.51850  0.7201  
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                      Estimate Std. Error t value
    ## (Intercept)           8.93464    0.97970   9.120
    ## max_temp             -0.06904    0.03755  -1.839
    ## avg_vwc               0.01102    0.00867   1.271
    ## avg_lai               0.01892    0.11000   0.172
    ## clippedyes           -0.93221    0.48438  -1.925
    ## compositionmixed     -0.12065    0.29061  -0.415
    ## clippedyes:manureyes  0.58766    0.28863   2.036
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la clppdy cmpstn
    ## max_temp    -0.865                                   
    ## avg_vwc     -0.096  0.176                            
    ## avg_lai     -0.112 -0.330 -0.370                     
    ## clippedyes  -0.161 -0.282 -0.288  0.803              
    ## compostnmxd -0.148  0.174  0.125 -0.350 -0.284       
    ## clppdys:mnr  0.013  0.013 -0.004 -0.055 -0.340  0.021
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient
    ## optimizer (nloptwrap) convergence code: 0 (OK)
    ## boundary (singular) fit: see ?isSingular

![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-4.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-5.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20length%20with%20LAI-6.png)<!-- -->

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

#### Average root volume model with LAI

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: 
    ## avg_volume_mm3 ~ max_temp + avg_vwc + avg_lai + clipped + clipped:manure +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_model_data
    ## 
    ## REML criterion at convergence: -41.5
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.5236 -0.4207 -0.0775  0.3879  4.8464 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance  Std.Dev.
    ##  Tube:block (Intercept) 0.0142528 0.1194  
    ##  block      (Intercept) 0.0106267 0.1031  
    ##  month_num  (Intercept) 0.0005061 0.0225  
    ##  Residual               0.0232132 0.1524  
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           1.033716   0.251366   4.112
    ## max_temp             -0.003715   0.009534  -0.390
    ## avg_vwc               0.002765   0.002203   1.255
    ## avg_lai              -0.033068   0.023802  -1.389
    ## clippedyes           -0.368398   0.108529  -3.394
    ## clippedyes:manureyes  0.159654   0.068569   2.328
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la clppdy
    ## max_temp    -0.877                            
    ## avg_vwc     -0.089  0.129                     
    ## avg_lai     -0.152 -0.268 -0.304              
    ## clippedyes  -0.184 -0.229 -0.226  0.775       
    ## clppdys:mnr  0.017  0.006 -0.011 -0.050 -0.353
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-2.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/tube%20avg%20volume%20with%20LAI-4.png)<!-- -->

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

#### Average root diameter model with LAI

![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-1.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-2.png)<!-- -->

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: 
    ## avg_diam_mm ~ max_temp + avg_vwc + avg_lai + clipped + clipped:manure +  
    ##     (1 | block/Tube) + (1 | month_num)
    ##    Data: tube_lai_model_data
    ## 
    ## REML criterion at convergence: -507.1
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.9037 -0.4624  0.0372  0.4067  5.1872 
    ## 
    ## Random effects:
    ##  Groups     Name        Variance  Std.Dev.
    ##  Tube:block (Intercept) 0.0002373 0.01540 
    ##  block      (Intercept) 0.0007123 0.02669 
    ##  month_num  (Intercept) 0.0009612 0.03100 
    ##  Residual               0.0003902 0.01975 
    ## Number of obs: 124, groups:  Tube:block, 24; block, 8; month_num, 5
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error t value
    ## (Intercept)           0.524005   0.112730   4.648
    ## max_temp             -0.008851   0.004196  -2.109
    ## avg_vwc               0.001523   0.001165   1.307
    ## avg_lai              -0.005716   0.003229  -1.770
    ## clippedyes           -0.032842   0.014485  -2.267
    ## clippedyes:manureyes  0.002696   0.008920   0.302
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) mx_tmp avg_vw avg_la clppdy
    ## max_temp    -0.971                            
    ## avg_vwc     -0.184  0.065                     
    ## avg_lai     -0.143  0.004  0.042              
    ## clippedyes  -0.055 -0.086  0.073  0.785       
    ## clppdys:mnr  0.061 -0.041 -0.110 -0.067 -0.356
    ## fit warnings:
    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-3.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-4.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-5.png)<!-- -->![](production_turnover_files/figure-gfm/avg%20root%20diam%20with%20LAI-6.png)<!-- -->

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
