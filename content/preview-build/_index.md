# Preview Build

## UPPAAL 5.0.0 beta2 since UPPAAL 5.0.0 beta1
- Fixed symbolic trace as concrete trace output to pass the regression suite by
- Fix version check serialization issue on startup
- Fix issue where fatal engine errors are lost when parsing BasicResponse
- Fixed version date parsing to be more robust
- Updated JetBrainMono fonts
- Added bold italic highlighting for `/// comments`
- Update old dtd version to fit model files

## UPPAAL 5.0.0 beta1 since UPPAAL 4.1.20 Stratego 11
- Graceful cancellation and other result output fixes
- Cleanup demo examples
- Fix ant release date and applied format validation to release dates
- Fix issue where plots would seemingly go backwards in time
- Swap result and query
- Fixed font and drawing anti-aliasing in the verification dialog
- Removed splashscreen as startup seems to be fast enough
- Fix issue where the last delay transition of a concrete witness trace would be omitted
- Fixed issues with advanced line break
- Recover concrete trace output on verifyta
- Add parsing for saving plot settings in concrete simulator
