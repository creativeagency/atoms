###
Global namespace for Atoms

@namespace Atoms

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

Atoms = @Atoms =
  version   : "0.11.22"
  Device    : {}
  Core      : {}
  Class     : {}

  Atom      : {}
  Molecule  : {}
  Organism  : {}
  Entity    : {}
  $         : (args...) -> if $$? then $$ args... else $ args...
