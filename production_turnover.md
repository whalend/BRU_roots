Root production and turnover
================

<!-- ## GitHub Documents -->
<!-- This is an R Markdown format used for publishing markdown documents to GitHub. When you click the **Knit** button all R code chunks are run and a markdown file (.md) suitable for publishing to GitHub is generated. -->

CW: use MR + models to get at dynamic rates with depth, and static cores
to get biomass/length with depth, then propagate them together to get
summed fluxes of production and turnover.

# Figures

1.  Length, Diameter, Production, Turnover by Depth

2.  Length, Diameter, Production, Turnover by Day of Year (Month)

## Number of roots across length bins

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

# Root measures aggregated to depth (“location”)

The sum of each metric was calculated at each combination of Tube,
Location (depth), Month & Date (equivalent but keeping Date handy), and
root\_status.

In the plots, points are the sum values and lines are the fit from
`geom_smooth(method = 'gam', formula = 'y ~ s(x, bs="cs)')`, same as
above.

We have totals for:

-   root length (mm)
-   projected area (mm2)
-   surface area (mm2)
-   average diameter (cm)
-   volume (mm3)

![](production_turnover_files/figure-gfm/total_root_length_depth_month-1.png)<!-- -->

“It develops mid-section girth - a beer belly - over the season” -CW :)

![](production_turnover_files/figure-gfm/total_avg_diam-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_surface_area-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_proj_area-1.png)<!-- -->

![](production_turnover_files/figure-gfm/total_volume-1.png)<!-- -->
