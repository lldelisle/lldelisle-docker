#!/usr/bin/env python

from bein import *
from bein.util import *
import sys, getopt, os

opts = getopt.getopt(sys.argv[1:],"d:m:",[])[0]
limspath = ([x[1] for x in opts if x[0]=='-d']+["/data/epfl/bbcf/htsstation/data/"])[0]
ml = ["mapseq","demultiplexing","chipseq","rnaseq","4cseq","snp","microbiome","dnaseseq"]
module_list = [x[1] for x in opts if x[0]=='-m' and x[1] in ml] or ml
base_url = 'http://htsstation.epfl.ch'

def do_it(name, gl_dict):
    lims = os.path.join(limspath,"%s_minilims" %name)
    print "**** "+lims+" ****\n"
    M = MiniLIMS( lims )
    alias = "global variables"
    M.delete_alias(alias)
    with execution( M, description='create '+alias ) as ex:
        add_pickle( ex, gl_dict, alias=alias )

    print "**** checking "+name+" ****\n"
    print M.fetch_file(alias)
    gl = use_pickle(M, alias)
    print gl
    print gl == gl_dict
    print "**** done ****\n\n"

def hts_urls(name,base=base_url):
    return { 'url': "%s/%s/" %(base,name),
             'download': "%s/data/%s/%s_minilims.files/" %(base,name,name) }

gl_dict = { 'genrep_url': '',
            'fastq_root': '',
            'gdv': {'url': 'http://gdv.epfl.ch/pygdv/',
                    'email': 'webmaster.bbcf@epfl.ch',
                    'key': 'ee0742e5d8764808f31ee2560011529d68ce2a43'},
            'email': {'sender': 'webmaster.bbcf@epfl.ch',
                      'smtp': 'localhost'},
            'script_path': '/usr/src/bbcfutils/R',
            'default_root': '/data/genrep',
            'bwt_root': '/data/genrep',
            'c4_url':'/data/4cLibraries',
            'bash_script_path': '/usr/src/bbcfutils/bash_scripts' }


for name in ml: gl_dict["hts_"+name] = hts_urls(name)

for name in module_list: do_it(name,gl_dict)

