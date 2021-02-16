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

April roots: 1403

New roots: 2596

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

## Production and loss (change) of individual roots

Calculate gross change for individual roots in length, diameter, and
volume between each time step, for alive, dead, gone. The change values
can then be aggregated to the depth window.

``` r
## Calculate change in length, diameter, and volume between each observation 
## for each root
ind_chg <- df %>% 
  select(obs_ID, root_ID, Tube, Location, Date, Session, Month, root_status, 
         Length_mm, AvgDiam_cm, Volume_mm3) %>% 
  arrange(root_ID, Session) %>% 
  group_by(root_ID, root_status, Tube, Location) %>% 
  # lag subtracts the previous value; NAs when there is no value to subtract
  mutate(length_change = Length_mm - lag(Length_mm, n = 1),
         diam_change = AvgDiam_cm - lag(AvgDiam_cm, n = 1),
         volume_change = Volume_mm3 - lag(Volume_mm3, n = 1)) %>% 
  ungroup(.)

## Sum change values to depth window
ind_chg_sum <- ind_chg %>% 
  group_by(Tube, Location, root_status, Month, Date) %>% 
  summarise(Length_mm = sum(Length_mm),
            AvgDiam_cm_sum = sum(AvgDiam_cm),# should this be averaged instead?
            Volume_mm3 = sum(Volume_mm3),
            length_change = sum(length_change, na.rm = T),
            diam_change = sum(diam_change, na.rm = T),
            volume_change = sum(volume_change, na.rm = T)
  ) %>% 
  ungroup(.)
```

The next three figures are of change values aggregated to depth window.

![](production_turnover_files/figure-gfm/plot_root_change-1.png)<!-- -->![](production_turnover_files/figure-gfm/plot_root_change-2.png)<!-- -->![](production_turnover_files/figure-gfm/plot_root_change-3.png)<!-- -->

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
