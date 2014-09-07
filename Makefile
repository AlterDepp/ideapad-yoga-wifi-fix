# Makefile for 2.6 kernels and up
#
# Will compile and install for other kernel than the currently running,
# given the TARGET parameter (should be the name of a directory in
# /lib/modules) e.g.
# make TARGET=2.6.32.10-90.fc12.x86_64
#
ifneq ($(KERNELRELEASE),)
obj-m	:= ideapad-laptop.o

else
ifeq ($(TARGET),)
TARGET := $(shell uname -r)
endif
PWD := $(shell pwd)
KDIR := /lib/modules/$(TARGET)/build

default:
	@echo $(TARGET) > module.target
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean:
	@rm -f *.ko *.o modules.order Module.symvers *.mod.? .ideapad-laptop.* *~
	@rm -rf .tmp_versions module.target

endif

KVER  := $(shell uname -r)
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/platform/x86
install: 
	cp ideapad-laptop.ko $(MODDESTDIR)

