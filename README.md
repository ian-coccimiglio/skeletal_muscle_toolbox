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

| Pipeline Name | Description | Journal | Citation | License |
|---------------|-------------|--------|----------|---------|
| TrueFAD | Modern ImageJ end-to-end pipeline | [TrueFAD](https://www.nature.com/articles/s41598-024-53658-0) | Brun et al., 2024, [DOI](https://doi.org/10.1038/s41598-024-53658-0) | [GPL3](https://github.com/AurBrun/TRUEFAD/blob/main/LICENSE) |
| MuscleJ2    | Modern end-to-end pipeline supporting a variety of options | [MuscleJ2]() | Danckaert et al., 2023, [DOI](https://doi.org/10.1186/s13395-023-00323-1) |  Unrestricted use, CC0 as per journal |
| MyoSight | End-to-End pipeline | [MyoSight](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7667765/) | Babcock et al., 2020, [DOI](https://doi.org/10.1186%2Fs13395-020-00250-5) | Unrestricted use, CC0 as per journal |
| MyoSAT | Muscle Imaging Pipeline for H&E stained samples | [MyoSAT](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7757813/) | Stevens et al., 2020, [DOI](https://doi.org/10.1371/journal.pone.0243163)| [Link to source](#) | Author(s), Year, [DOI](#) | License type |
| Open-CSAM | Brief description of the pipeline | [Open-CSAM](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0186-6) | Desgeorges et al., 2019, [DOI](https://doi.org/10.1186/s13395-018-0186-6) | Unrestricted use, [CC-BY-4.0]() as per journal |
| MuscleJ    | Open-source pipeline (Deprecated for MuscleJ2)  | [MuscleJ](https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0171-0) | Mayeuf-Louchart et al., 2018, [DOI](https://doi.org/10.1186/s13395-018-0171-0) | [GPL3](https://github.com/ADanckaert/MuscleJ/blob/master/License.txt) | 
| Bonilla | Brief description of the pipeline. | [Link to source](#) | Author(s), Year, [DOI](#) | License type |
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

