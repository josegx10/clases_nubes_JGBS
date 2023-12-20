# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-src"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-build"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/tmp"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/src"
  "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp"
)

set(configSubDirs Debug;Release;MinSizeRel;RelWithDebInfo)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "E:/proyectos/flutter/clases_nubes_JGBS/proyecto_citas_medicas/build/windows/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp${cfgdir}") # cfgdir has leading slash
endif()
