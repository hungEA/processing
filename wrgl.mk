WRGL := wrgl

pull_person:
	@if [[ ! -f $(BUILD_DIR)/person.csv || "$(shell wrgl pull person)" != *"Already up to date."* ]]; then \
		$(WRGL) export person > $(BUILD_DIR)/person.csv && \
		echo 'exported person branch to file $(BUILD_DIR)/person.csv'; \
	else \
		echo 'file $(BUILD_DIR)/person.csv is up to date.'; \
	fi

$(DIRK_DATA_DIR)/fuse/person.csv: $(DIRK_MD5_DIR)/fuse/cross_agency.py.md5 $(DIRK_DATA_DIR)/fuse/personnel.csv $(DIRK_DATA_DIR)/fuse/event.csv | pull_person
	$(call dirk_execute,fuse/cross_agency.py $(BUILD_DIR)/person.csv)
