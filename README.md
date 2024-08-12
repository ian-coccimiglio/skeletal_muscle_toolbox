# Skeletal Muscle Imaging Tools
Distributing macros for scientific skeletal muscle imaging in ImageJ and Fiji.

This repository consolidates various skeletal muscle imaging pipelines from published literature. 

## Table of Contents

- [Introduction](#Introduction)
- [Pipelines](#Pipelines)
- [Contributing](#Contributing)
- [License](#License)

## Introduction

This resource serves to gather, distribute, and document pipelines relating to skeletal muscle imaging, particularly those that operate within FIJI and ImageJ.

Software referenced here must:
1) Provide functionality for skeletal muscle imaging
2) Be in the form of a macro, script, or ImageJ/FIJI plugin
3) Operate within the FIJI/ImageJ environment
4) Be publically accessible.

Software distributed here must
1) Software is licensed appropriately
2) Software is open-source

## Pipelines

| Pipeline Name and Publication | Description | Source | Citation | License |
|---------------|-------------|--------|----------|---------|
| [TrueFAD](https://www.nature.com/articles/s41598-024-53658-0) | Modern fully-automated end-to-end pipeline for histology | [GitHub](https://github.com/AurBrun/TRUEFAD?tab=readme-ov-file) | Brun et al., 2024, [DOI](https://doi.org/10.1038/s41598-024-53658-0) | [GPL3](https://github.com/AurBrun/TRUEFAD/blob/main/LICENSE) |
| [MuscleJ2](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-023-00323-1#citeas)    | Modern fully-automated end-to-end pipeline supporting a variety of options | [GitHub](https://github.com/ADanckaert/MuscleJ2/tree/Plugin) | Danckaert et al., 2023, [DOI](https://doi.org/10.1186/s13395-023-00323-1) |  Unrestricted use, CC0 as per journal |
| [MyoSight](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7667765/) | End-to-end semi-automated pipeline | [GitHub](https://github.com/LyleBabcock/MyoSight) | Babcock et al., 2020, [DOI](https://doi.org/10.1186%2Fs13395-020-00250-5) | Unrestricted use, CC0 as per journal |
| [MyoSAT](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7757813/)| Muscle imaging pipeline for H&E stained samples | [GitHub](https://github.com/CheethamLab/MyoSAT_ImageJ_Macro/) | Stevens et al., 2020, [DOI](https://doi.org/10.1371/journal.pone.0243163) | Open-source, CC-BY-4.0 as per journal |
| [Open-CSAM](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0186-6) | Semi-automatic ImageJ processing macro | Desgeorges et al., 2019, [DOI](https://doi.org/10.1186/s13395-018-0186-6) | Unrestricted use, CC-BY-4.0 as per journal |
| [MuscleJ](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0171-0)    | Open-source automatic pipeline (Deprecated for MuscleJ2)  | [GitHub](https://github.com/ADanckaert/MuscleJ) | Mayeuf-Louchart et al., 2018, [DOI](https://doi.org/10.1186/s13395-018-0171-0) | [GPL3](https://github.com/ADanckaert/MuscleJ/blob/master/License.txt) | 
| Bonilla | Brief description of the pipeline. | [Link to source](#) | Author(s), Year, [DOI](#) | License type |
| Tyagi | Brief description of the pipeline. | [Link to source](#) | Author(s), Year, [DOI](#) | License type |
| LabelsToROIs | Conversion and Erosion of Fiber ROIs created by Cellpose | [Link to source](#) | Author(s), Year, [DOI](#) | License type |


Abbreviations:
FT: Skeletal Muscle Fiber-Typing
CN: Central Nucleation
PN: Peri Nucleation
CSA: Cross-sectional Area
FER: Feret
CAP: Capillaries Measurement
SAT: Satellite Cells
VES: Vessel Identification

## Contributing

Contributions are welcome! If you have a pipeline to add or improvements to suggest, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b new-branch`).
3. Make and commit your changes (`git commit -m 'Add new pipeline'`).
4. Push to the branch (`git push origin new-branch`).
5. Open a Pull Request to the main branch

## License

This repository is licensed under the [MIT License](LICENSE). Please ensure that you comply with the licenses of the individual pipelines included in this repository.

