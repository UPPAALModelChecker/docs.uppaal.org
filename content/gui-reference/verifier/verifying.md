---
title: Verifying Requirements
weight: 20
---

The queries (i.e. the system requirements) are verified from the verifier interface of UPPAAL. A verification is always performed according to the settings specified in the [Options menu](/gui-reference/menu-bar/options/) of the main menu bar.

The selected queries are verified when the button named _Check_ is pressed. The verification progress dialog displays the progress of how many queries have been verified, what is the current load of a passed-waiting list, current processor time usage (the time spent for verification is in blue, the time spent by operating system is in red), current usage of host's random access memory (verification memory is in blue, memory used by other running processes is in gray and operating system cache and buffers are in yellow), swap disk usage (swapped out verification is in blue, other is in grey). Note that resource figures do not include the overhead of UPPAAL GUI and command line utilities (like <tt>memtime</tt> run on <tt>verifyta</tt>) are more accurate. Some figures are not available on some OSes (system cache allocation is not documented on Windows API and swap usage per process is not maintained by Linux kernel), therefore they might not show up.

The verification output is displayed in the _Status_ field at the bottom of the verifier panel. The result is also indicated by the circular markers in the rightmost column of the _Overview_ panel. A grey marker indicates that the truth value of the property is unknown, a green marker that the property is satisfied, and a red marker that the property is not satisfied.

In case the _Over Approximation_ or the _Under Approximation_ options are enabled, the output of the verifier might be that property is "maybe satisfied". This happens when the verifier cannot determine the truth value of the property due to the approximations used.

## Statistical Model Checking

Parameters for statistical model checking can be changed in the [Options](/gui-reference/menu-bar/options/) menu. Various data plots (if available) can be accessed via popup-menu by right-clicking the statistical property. The y-axis always denotes a probability or its density, while x-axis denotes either the variable values limited by the statistical query or a step (transition) count in the model run.

<dl>

<dt>Probability density distribution</dt>

<dd>A histogram created from probability distribution where each bucket is normalized by a bucket width. Useful for comparison of various distributions, potentially with different bucket widths.</dd>

<dt>Probability distribution</dt>

<dd>A histogram created from a frequency histogram where each bucket is normalized by a total number of runs. Useful for assessing a probability of a property being satisfied at a particular moment in time interval.</dd>

<dt>Cumulative probability distribution</dt>

<dd>A histogram created by adding up all frequency histogram buckets up to the current bucket and normalized by a total number of runs.</dd>

<dt>Confidence Intervals for Probabilities</dt>

<dd>The confidence intervals for probabilities are computed using Clopper-Pearson method (also known as "exact") for binomial distribution for a given level of confidence (1-α). The method is conservative in a sense that it guarantees the minimum coverage of the real probability in (1-α) of cases. In the plots, the estimated confidence is valid only for one bucket at a time (the gathered data is reused to compute each individual bucket).</dd>

<dt>Confidence Intervals for Mean</dt>

<dd>The confidence intervals for mean estimation are computed using quantiles of Student's t-distribution for a given level of confidence of 1-α. Note that t-distribution approaches the commonly used Normal (Gaussian) distribution when the number of samples is high.</dd>

<dt>Frequency histogram</dt>

<dd>The frequency histogram is created by calculating the number of runs satisfying the property at a particular moment in time interval. Useful for calculating the number of runs.</dd>

</dl>

Any plot can be customized from a popup menu by right-clicking on the plot.

Further, the plot labels and titles can be edited and several data sets can be superimposed in one figure by using Plot Composer, accessible from the [Tools](/gui-reference/menu-bar/tools/) menu. It is possible to create several composite plots at a time by invoking Plot Composer multiple times.

An extensive overview and comparison of methods for computing confidence intervals for binomial distribution can be found in the following publications:

> _Interval Estimators for a Binomial Proportion: Comparison of Twenty Methods_, Ana M. Pires and Conceicao Amado. REVSTAT -- Statistical Journal, Vol.6, No.2, June 2008, pages 165-197.

> _Interval Estimation for a Binomial Proportion_, Lawrence D. Brown, T. Tony Cai and Anirban DasGupta. Statistical Science, 2001, Vol.16, No.2, pages 101-133.