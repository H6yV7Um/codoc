
prjdir = $(shell dirname `pwd`)

distdir = 'hd.weibo.com/pc'
testdir = 'simulated/pc'
#distdir = $(shell basename $(prjdir))


release-diff:
        cd $(prjdir); $(prjdir)/releaser/bin/diff.sh $(tag);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/releaser/diff/$(shell basename $(prjdir))/ 10.85.47.54::wbcsc_www/$(distdir);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/releaser/diff/$(shell basename $(prjdir))/ 10.85.47.55::wbcsc_www/$(distdir);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/releaser/diff/$(shell basename $(prjdir))/ 10.85.47.56::wbcsc_www/$(distdir);


release-all:
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/ 10.85.47.54::wbcsc_www/$(distdir);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/ 10.85.47.55::wbcsc_www/$(distdir);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/ 10.85.47.56::wbcsc_www/$(distdir);



test-diff:
        cd $(prjdir); $(prjdir)/releaser/bin/diff.sh $(tag);
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/releaser/diff/$(shell basename $(prjdir))/ 10.85.47.55::wbcsc_www/$(testdir);


test-all:
        cd $(prjdir); rsync -avz --exclude-from releaser/conf/excludefiles $(prjdir)/ 10.85.47.55::wbcsc_www/$(testdir);

