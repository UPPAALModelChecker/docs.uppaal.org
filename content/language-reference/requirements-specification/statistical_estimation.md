# Confidence Interval Estimation

Statistical queries without the number of runs specified, the estimation is performed adaptively: simulate, collect the statistics and repeat if more data is needed.

The confidence intervals converge to the true probability (P) value as more samples are produced:

![CIs for P=0.5](ci_0.5.png) ![CIs for P=0.2](ci_0.2.png) ![CIs for P=0.1](ci_0.1.png) ![CIs for P=0.05](ci_0.05.png) ![CIs for P=0.01](ci_0.01.png) ![CIs for P=0](ci_0.png)

Note that occasionally the confidence intervals may overstep and thus exclude the true probability value, which should not happen more often than the specified level of significance (α).

The width of the confidence intervals converges to zero as more samples are produced:

![P=0.5](ciw_0.5.png) ![P=0.2](ciw_0.2.png) ![P=0.1](ciw_0.1.png) ![P=0.05](ciw_0.05.png) ![P=0.01](ciw_0.01.png) ![P=0](ciw_0.png)

Note that in case of extreme probability value (close to 0 or 1, e.g. P=0.01), repeated observations are more likely and thus they may create false confidence that the probability is extreme (i.e. 0 or 1), but then a single differing observation may disturb the interval size and therefore more samples are required than just single sided interval. Therefore newer Uppaal versions use double-sided confidence interval estimation.
