terraform{
    source ="../../bd-terra-modules/lb-block"
}

include "root" {
    path = find_in_parent_folders()
}