PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

SCRIPT = keepassxc-fzf

.PHONY: install uninstall

install:
	@echo "Installing $(SCRIPT) to $(BINDIR)..."
	@install -d $(BINDIR)
	@install -m 755 $(SCRIPT) $(BINDIR)/$(SCRIPT)
	@echo "Installation complete."
	@echo "Run 'keepassxc-fzf --help' to see available options."

uninstall:
	@echo "Uninstalling $(SCRIPT) from $(BINDIR)..."
	@rm -f $(BINDIR)/$(SCRIPT)
	@echo "Uninstallation complete."
