{
  pkgs,
  lib,
  stdenv,
  ...
}:
let
  pythonPackages = pkgs.python313Packages;
in
pkgs.mkShell {
  buildInputs = [
    pythonPackages.python
    pythonPackages.venvShellHook
    pkgs.autoPatchelfHook
    pythonPackages.pandas
    pythonPackages.matplotlib
    pythonPackages.seaborn
    pythonPackages.openpyxl
    pythonPackages.scikit-learn
    pythonPackages.lightgbm
    pythonPackages.shap
    pythonPackages.optuna

  ];
  venvDir = "./.venv";
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -U jupyter
    autoPatchelf ./.venv
  '';
  postShellHook = ''
    unset SOURCE_DATE_EPOCH
    export LD_LIBRARY_PATH=${lib.makeLibraryPath [ stdenv.cc.cc ]}
    jupyter notebook
  '';
}
