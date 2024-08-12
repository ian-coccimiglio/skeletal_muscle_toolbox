# Skeletal Muscle Imaging Toolbox
Distributing tools and pipelines for scientific skeletal muscle imaging in ImageJ and Fiji.

## Table of Contents

- [Introduction](#Introduction)
- [Pipelines](#Pipelines)
- [Contributing](#Contributing)
- [License](#License)

## Introduction

This resource serves to collect, distribute, and document pipelines and tools relating to skeletal muscle imaging, particularly those that operate within FIJI and ImageJ.

The main goal is to provide all the plugins in one repository, such that users can easily find and use them. If this proves to be helpful, it can be turned into an ImageJ Update Site.

If you DO use any of the tools in this toolbox, remember to cite the original author using the table below!

## Pipelines

| Pipeline Name and Publication | Description | Source-code | Citation + DOI | License | Distributed with Skeletal Muscle Toolbox | 
|-------------------------------|--------------|------------|----------------|---------|:---------------------------------------:|
| [TrueFAD\_Histo](https://www.nature.com/articles/s41598-024-53658-0) | Modern fully-automated end-to-end deep-learning pipeline for histology and myotube measurement | [GitHub](https://github.com/AurBrun/TRUEFAD?tab=readme-ov-file) | [Brun et al., 2024](https://doi.org/10.1038/s41598-024-53658-0) | [GPL3](https://github.com/AurBrun/TRUEFAD/blob/main/LICENSE) | Yes |
| [MuscleJ2](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-023-00323-1#citeas)    | Modern fully-automated end-to-end pipeline supporting a variety of outputs | [GitHub](https://github.com/ADanckaert/MuscleJ2/tree/Plugin) | [Danckaert et al., 2023](https://doi.org/10.1186/s13395-023-00323-1) | CC0, as per journal |
| [LabelsToROIs](https://www.nature.com/articles/s41598-021-91191-6) | Converter from Label-Images to ROIs + ROI erosion. | [GitHub](https://github.com/ariel-waisman/LabelsToROIs/tree/master) | [Waisman et al., 2021](https://doi.org/10.1038/s41598-021-91191-6) | [GPL3](https://github.com/ariel-waisman/LabelsToROIs/blob/master/LICENSE) | Yes
| [MyoSight](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7667765/) | End-to-end semi-automated pipeline | [GitHub](https://github.com/LyleBabcock/MyoSight) | [Babcock et al., 2020](https://doi.org/10.1186%2Fs13395-020-00250-5) | CC0 as per journal | Yes |
| [Myosoft](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0229041) | Fiber-Typing of using Machine-Learning Algorithm | [GitHub](https://github.com/Hyojung-Choo/Myosoft/tree/Myosoft-hub) | [Encarnacion-Rivera et al., 2020](https://doi.org/10.1371/journal.pone.0229041) | GPL3 (via source code) | Yes (Version 15) |
| [MyoSAT](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7757813/)| Muscle imaging pipeline for H&E stained samples | [GitHub](https://github.com/CheethamLab/MyoSAT_ImageJ_Macro/) | [Stevens et al., 2020](https://doi.org/10.1371/journal.pone.0243163) | CC-BY-4.0 as per journal | Yes (Version 3.5) |
| [Open-CSAM](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0186-6) | Semi-automatic ImageJ processing macro | [PDF Download](https://static-content.springer.com/esm/art%3A10.1186%2Fs13395-018-0186-6/MediaObjects/13395_2018_186_MOESM1_ESM.pdf) | [Desgeorges et al., 2019](https://doi.org/10.1186/s13395-018-0186-6) | CC-BY-4.0, as per journal |
| [Fernandez](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-019-0200-7#citeas) | Fiber Morphometry and Fiber-Type of Human Skeletal Muscle. | [IJM](https://static-content.springer.com/esm/art%3A10.1186%2Fs13395-019-0200-7/MediaObjects/13395_2019_200_MOESM2_ESM.txt) | [Reyes-Fernandez et al., 2019](https://doi.org/10.1186/s13395-019-0200-7) | CC0, as per journal |
| [Bonilla](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7732929/) | A heavily modified version of MuscleJ for human skeletal muscle. | [IJM 1](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7732929/bin/11357_2020_266_MOESM4_ESM.ijm) & [IJM 2](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7732929/bin/11357_2020_266_MOESM5_ESM.ijm) | [Bonilla et al., 2018](https://doi.org/10.1007%2Fs11357-020-00266-1) | GPL3 (via source code) | Yes |
| [MuscleJ](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0171-0)    | Open-source automatic pipeline (Deprecated for MuscleJ2)  | [GitHub](https://github.com/ADanckaert/MuscleJ) | [Mayeuf-Louchart et al., 2018](https://doi.org/10.1186/s13395-018-0171-0) | [GPL3](https://github.com/ADanckaert/MuscleJ/blob/master/License.txt) | 


## Pipeline Feature Comparison

| Feature                | FT     | NUC    | MEAS   | VAS     | SAT     | FLUOR   | H&E     | ML/DL   |
|------------------------|--------|--------|--------|---------|---------|---------|---------|---------|
| TrueFAD\_Histo          | ✅     |&#9744; | ✅      | &#9744; | &#9744; | ✅      | &#9744; | ✅      |
| MuscleJ2               | ✅     | ✅     | ✅      | ✅       | ✅      | ✅      | &#9744; | &#9744; |
| LabelsToROIs           |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| MyoSight               |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| Myosoft                |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| MyoSAT                 |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| Open-CSAM              |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| Fernandez              |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| MuscleJ                |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |
| Bonilla                |&#9744; |&#9744; |&#9744; | &#9744; | &#9744; | &#9744; | &#9744; | &#9744; |

*If the plugin has no name, the first authors surname was used as an identifier. 

Abbreviations:
- FT   : Provides Fiber-Typing
- NUC  : Provides Fiber Nucleation (Central/Peripheral)
- MEAS  : Morphological measures (CSA/Feret)
- VAS  : Can annotate capillaries/vasculature
- SAT  : Can annotate satellite cells
- FLUOR : Compatible with fluorescence imaging
- H&E   : Compatible with H&E staining
- ML/DL : Machine/Deep Learning

## Criteria
Software referenced here must:
1) Provide functionality for skeletal muscle imaging
2) Be in the form of a macro, script, or ImageJ/FIJI plugin
3) Operate within the FIJI/ImageJ environment
4) Be publically accessible.

Software distributed here must
1) Be licensed appropriately for redistribution
2) Be open-source

## Contributing

Contributions are welcome! If you have a pipeline or muscle-imaging tool to add, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b new-branch`).
3. Make and commit your changes (`git commit -m 'Add new pipeline'`).
4. Push to the branch (`git push origin new-branch`).
5. Open a Pull Request to the main branch

## License

This repository is licensed under the [MIT License](LICENSE). Please ensure that you comply with the licenses of the individual pipelines included in this repository.
