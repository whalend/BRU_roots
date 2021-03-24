Root production and turnover
================

-   [Calculating Estimates of Root Production and
    Turnover](#calculating-estimates-of-root-production-and-turnover)
-   [Figures](#figures)
    -   [Production and loss (change) of individual
        roots](#production-and-loss-change-of-individual-roots)
    -   [Root measurements aggregated to depth window
        (“location”)](#root-measurements-aggregated-to-depth-window-location)
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

# Figures

1.  Length, Diameter, Production, Turnover by Depth

2.  Length, Diameter, Production, Turnover by Day of Year (Month)

<!-- Size (diameter) & depth biplot of days to senescence -->

    ## # A tibble: 86,629 x 38
    ##    obs_ID root_ID SampleId RootName  Tube Location Date        Time Session
    ##    <chr>  <chr>   <chr>    <chr>    <dbl>    <dbl> <date>     <dbl>   <dbl>
    ##  1 1_1_1… 1_1_R1… BRUROOT… R1           1        1 2020-04-21 94911       1
    ##  2 1_1_1… 1_1_R2… BRUROOT… R2           1        1 2020-04-21 94911       1
    ##  3 1_1_2… 1_2_R1… BRUROOT… R1           1        2 2020-04-21 94925       1
    ##  4 1_1_2… 1_2_R2… BRUROOT… R2           1        2 2020-04-21 94925       1
    ##  5 1_1_2… 1_2_R3… BRUROOT… R3           1        2 2020-04-21 94925       1
    ##  6 1_1_2… 1_2_R4… BRUROOT… R4           1        2 2020-04-21 94925       1
    ##  7 1_1_2… 1_2_R5… BRUROOT… R5           1        2 2020-04-21 94925       1
    ##  8 1_1_2… 1_2_R6… BRUROOT… R6           1        2 2020-04-21 94925       1
    ##  9 1_1_2… 1_2_R7… BRUROOT… R7           1        2 2020-04-21 94925       1
    ## 10 1_1_2… 1_2_R8… BRUROOT… R8           1        2 2020-04-21 94925       1
    ## # … with 86,619 more rows, and 29 more variables: DataGatherer <chr>,
    ## #   BirthSession <dbl>, DeathSession <dbl>, TotLength_mm <dbl>,
    ## #   TotProjArea_mm2 <dbl>, TotSurfArea_mm2 <dbl>, TotAvgDiam_mm <dbl>,
    ## #   TotVolume_mm3 <dbl>, Length_mm <dbl>, ProjArea_mm2 <dbl>,
    ## #   SurfArea_mm2 <dbl>, AvgDiam_mm <dbl>, Volume_mm3 <dbl>, TipDiam <dbl>,
    ## #   TipLivStatus <chr>, HighestOrder <dbl>, ExtPathLength <dbl>,
    ## #   Altitude <dbl>, root_status <chr>, rowID <chr>, Month <dbl>,
    ## #   length_bin <fct>, diam_bin <fct>, block <dbl>, composition <chr>,
    ## #   plot <dbl>, subplot <chr>, treatment <chr>, type <chr>

## Production and loss (change) of individual roots

Calculate gross change for individual roots in length, diameter, and
volume between each time step, for alive, dead, gone. The change values
can then be aggregated to the depth window.

<!-- CW: I think the main change is that we need to separate out the gains and losses. So, ind_gain_sum should actually be split into gross gain and gross loss. Then, the next step is to add new roots into the gross gain, and add newly dead or gone roots to the gross loss. -->
<!-- After doing that, we aggregate to each depth window, but now have gross production and gross turnover by window. -->
<!-- Is "gross loss" then the sum of 'Dead', 'Gone' and negative values of 'Alive'? -->

**Gross Gain** = growth of existing roots + new roots

**Gross Loss** = loss of existing roots + dead roots + gone roots

``` r
## Calculate gross gain and gross loss in length, diameter, and
## volume between each observation for each root

# calculate change of individual roots
## given the definition of gross gain & loss could do only 'Alive'
ind_chg <- df %>% 
  select(obs_ID, root_ID, Tube, Location, Date, Session, Month, root_status, 
         Length_mm, AvgDiam_mm, Volume_mm3, treatment) %>% 
  arrange(root_ID, Session) %>% 
  group_by(root_ID, root_status, Tube, Location, treatment) %>% 
  # lag subtracts the previous value; NAs when there is no value to subtract
  mutate(length_change = Length_mm - lag(Length_mm, n = 1),
         diam_change = AvgDiam_mm - lag(AvgDiam_mm, n = 1),
         volume_change = Volume_mm3 - lag(Volume_mm3, n = 1)) %>% 
  ungroup(.)

## Not a very elegant solution follows...
ind_gross_chg <- ind_chg %>% 
  select(-Length_mm:-Volume_mm3) %>%
  rename(length = length_change, diameter = diam_change, 
         volume = volume_change) %>% 
  # long format to use metric as grouping variable
  pivot_longer(length:volume)

# gross gain = growth of 'Alive' + new roots
growth <- ind_gross_chg %>% 
  # summarise growth of existing roots to each depth
  filter(root_status == 'Alive', value >= 0) %>% 
  group_by(Tube, Location, Month, name, treatment) %>% 
  summarise(root_growth = sum(value)) %>% 
  ungroup(.)
# summary(growth)

# New roots after April
new_roots <- ind_gross_chg %>%
  # only roots that have NA for the change value
  filter(Month > 4, root_status == 'Alive', is.na(value)) %>% 
  distinct(root_ID, Tube, Location, Month, treatment) %>% 
  # get only these root IDs & recombine with gross values
  left_join(., ind_chg %>% select(root_ID, Tube, Location, Month, Length_mm:Volume_mm3)) %>%
  # rename in prep for joining with 'growth' data frame
  rename(length = Length_mm, diameter = AvgDiam_mm, 
         volume = Volume_mm3) %>%
  # match data format of 'growth'
  pivot_longer(length:volume) %>% 
  group_by(Tube, Location, Month, name, treatment) %>% 
  summarise(new_roots = sum(value)) %>% 
  ungroup(.)
# summary(new_roots)
# new_roots %>% filter(new_roots>100)

# join growth with new roots
gain_depth <- left_join(growth, new_roots)
# add growth & new roots to get gross gain
gain_depth <- gain_depth %>% 
  mutate(
    # hacky solve of NAs from the join
    new_roots = ifelse(is.na(new_roots), 0, new_roots),
    gross_gain = root_growth + new_roots
    )
gain_depth %>% summary()
```

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

``` r
# gross loss = loss in 'Alive' + 'Dead' + 'Gone' 
# get loss in 'Alive' roots (analogous to 'growth')
loss <- ind_gross_chg %>%
  filter(root_status == 'Alive' & value < 0) %>% 
  group_by(Tube, Location, Month, name, treatment) %>% 
  summarise(root_loss = sum(abs(value))) %>% 
  ungroup(.)

# get amounts *newly* 'Dead' and 'Gone' roots (analogous to new_roots)
dead_gone <- ind_gross_chg %>%
  # only Dead & Gone roots that have NA for the change value
  filter(Month > 4, root_status %in% c('Dead', 'Gone'),
         is.na(value)) %>% 
  # get only these root IDs & recombine with gross values
  distinct(root_ID, Tube, Location, Month, treatment) %>% 
  left_join(., ind_chg %>% select(root_ID, Tube, Location, Month, Length_mm:Volume_mm3, treatment)) %>%
  rename(length = Length_mm, diameter = AvgDiam_mm,
         volume = Volume_mm3) %>%
  pivot_longer(length:volume) %>% 
  group_by(Tube, Location, Month, name, treatment) %>% 
  summarise(dg_roots = sum(value)) %>% 
  ungroup(.)

loss_depth <- left_join(dead_gone, loss)
loss_depth <- loss_depth %>% 
  mutate(root_loss = ifelse(is.na(root_loss), 0, root_loss),
    gross_loss = dg_roots + root_loss)
summary(loss_depth)
```

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

``` r
# Combine so that gross gain and gross loss are in one data frame
gross_change <- df %>%
  filter(Month > 4) %>% 
  distinct(Tube, Location, Month, treatment) %>% 
  left_join(., gain_depth) %>% 
  left_join(., loss_depth)
```

Figure of gross gain and gross loss aggregated to depth window.

![](production_turnover_files/figure-gfm/plot_root_change-1.png)<!-- -->

Compare calculated gross change (gain - loss) from T\_1\_ to T\_2\_ to
the observed total at T\_2\_ of root length for each window. \#\#\#
Sanity Check

``` r
df1 <- left_join(
  df %>% filter(root_status == "Alive") %>% 
    group_by(Tube, Location, Month, treatment) %>% 
    summarise(TotLength_mm = sum(TotLength_mm)),
  gross_change %>% 
    filter(name == "length")
) %>% 
  ungroup(.)
df1 <- df1 %>% 
  select(Tube:TotLength_mm, gross_gain, gross_loss) %>% 
  mutate(calc_net = lag(TotLength_mm, n = 1) + gross_gain - gross_loss)
# View(df1)

# A peek at the resulting dataframe
df1
```

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

``` r
ggplot(df1, aes(TotLength_mm, calc_net)) +
  geom_point() +
  geom_abline(slope = 1) +
  ylab("Calculated net of gross gain and gross loss") +
  xlab("Observed minirhizo TotLength (mm)") +
  theme_classic() +
  NULL
```

![](production_turnover_files/figure-gfm/sanity%20check%20gain%20loss-1.png)<!-- -->

``` r
# I think we're pretty okay here

with(df1, cor(calc_net, TotLength_mm, use = "complete.obs"))
```

    ## [1] 0.9977984

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

## Root measurements aggregated to depth window (“location”)

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

![](production_turnover_files/figure-gfm/total_root_length_depth_month-1.png)<!-- -->

“It develops mid-section girth - a beer belly - over the season” -CW :)

![](production_turnover_files/figure-gfm/total_avg_diam-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_volume-1.png)<!-- -->

<!-- Are these surface area estimates of current interest? -->

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
