# Summertime surface temperature variability

**IMPORTANT:** Note that I used MATLAB 2007b for this project.

## Directories

- `data/`: data files and relevant download scripts
- `ettenne/`: scripts that make the MATLAB playground for exploring summertime
  surface temperature variability
- `file_exchange/`: MATLAB file exchange libraries used in this project
- `map/` and `m_map`: MATLAB geo mapping library used in this project

## Data

Information about the GCM / Reanalysis data used can be found in `data/README`
and in the corresponding `data/<model_name>/README`files.

Most download scripts make `wget` request to the IRIDL website URLs - so if that
website changed its URL signature in any way, they won't work unfortunately.

## MATLAB playground

Each sub-directory in `etienne/` is a MATLAB _playground_ corresponding
roughly to each section of the thesis.

The typical workflow is:

- `cd` into the `etienne/<playground>` of interest
- open up the playground's `startup.m` file,
  select the GCM / Reanalysis of interest under the `model_name` variable,
  and save.
- boot up MATLAB
- run the `startup.m` script in the MATLAB shell. This scripts:
    + defines all the required paths
    + load up all the relevent dataset
    + trims the fields to summer-only and land-only
    + computes the anomaly fields

When comparing different the results from different models I usually had
multiple MATLAB processes running in different with different `model_name` set.

See `etienne/README` and the corresponding `etienne/<playground>/README` files
for more information.

## Other information

### Replicate thesis figures

See `etienne/thesis_figs.sh`

### Why a playground ???

Converting multiple big NetCDF is slow on weak hardware, so I tried to solve
this problem but converting all NetCDF upon startup and make the extracted
globals for all the computation and plotting scripts.

In retrospect, even though the _playground_ format somewhat solved the NetCDF
issue, it wasn't so great at making the scripts potable and composable.

I apologize for any inconvenience.
