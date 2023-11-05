FROM registry.fedoraproject.org/fedora-toolbox:39 AS fedora-distrobox

# Install packages required by Distrobox, this speeds up the first-run time
RUN dnf install -y \
        bash-completion \
        bc \
        bzip2 \
        curl \
        diffutils \
        dnf-plugins-core \
        findutils \
        glibc-all-langpacks \
        glibc-locale-source \
        gnupg2 \
        gnupg2-smime \
        hostname \
        iproute \
        iputils \
        keyutils \
        krb5-libs \
        less \
        lsof \
        man-db \
        man-pages \
        mtr \
        ncurses \
        nss-mdns \
        openssh-clients \
        pam \ 
        passwd \
        pigz \ 
        pinentry \
        procps-ng \
        rsync \
        shadow-utils \
        sudo \ 
        tcpdump \
        time \ 
        traceroute \
        tree \ 
        tzdata \
        unzip \ 
        util-linux \
        vte-profile \
        wget \
        which \ 
        whois \
        words \
        xorg-x11-xauth \
        xz \
        zip \
        mesa-dri-drivers \
        mesa-vulkan-drivers \
        vulkan

# Set up dependencies
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox && \
    dnf install -y 'dnf-command(copr)'

# Set up cleaner Distrobox integration
RUN dnf copr enable -y kylegospo/distrobox-utils && \
    dnf install -y \
        xdg-utils-distrobox \
        adw-gtk3-theme && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/flatpak

# Install RPMFusion for hardware accelerated encoding/decoding
RUN dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    dnf install -y \
        intel-media-driver \
        nvidia-vaapi-driver && \
    dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld && \
    dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

# Cleanup
RUN rm -rf /tmp/*