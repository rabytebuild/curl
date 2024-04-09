#!/bin/sh

ROOTFS_DIR=/home/runner
export PATH=$PATH:~/.local/usr/bin

max_retries=50
timeout=1

ARCH=$(uname -m)
case $ARCH in
  x86_64) ARCH_ALT=amd64 ;;
  aarch64) ARCH_ALT=arm64 ;;
  *)
    echo "Unsupported CPU architecture: $ARCH"
    exit 1
    ;;
esac

if [ ! -e $ROOTFS_DIR/.installed ]; then
  echo "Choose OS:"
  echo "0) Debian"
  echo "1) Ubuntu (RDP Support)"
  echo "2) Alpine"

  # Automatically select option 1
  echo "1" > answer.txt

  # Read the answer from the file
  read -r input < answer.txt

  case $input in
    0)
      wget --tries=$max_retries --timeout=$timeout --no-hsts -O /tmp/rootfs.tar.xz \
        "https://github.com/termux/proot-distro/releases/download/v3.10.0/debian-${ARCH}-pd-v3.10.0.tar.xz"
      apt download xz-utils
      deb_file=$(find $ROOTFS_DIR -name "*.deb" -type f)
      dpkg -x $deb_file ~/.local/
      rm "$deb_file"
      tar -xJf /tmp/rootfs.tar.xz -C $ROOTFS_DIR
      ;;
    1)
      wget --tries=$max_retries --timeout=$timeout --no-hsts -O /tmp/rootfs.tar.gz \
        "http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.4-base-${ARCH_ALT}.tar.gz"
      tar -xf /tmp/rootfs.tar.gz -C $ROOTFS_DIR
      ;;
    2)
      wget --tries=$max_retries --timeout=$timeout --no-hsts -O /tmp/rootfs.tar.gz \
        "https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/alpine-minirootfs-3.18.3-${ARCH}.tar.gz"
      tar -xf /tmp/rootfs.tar.gz -C $ROOTFS_DIR
      ;;
    *)
      echo "Invalid selection. Exiting."
      exit 1
      ;;
  esac
fi

if [ ! -e $ROOTFS_DIR/.installed ]; then
  mkdir -p $ROOTFS_DIR/usr/local/bin
  wget --tries=$max_retries --timeout=$timeout --no-hsts -O $ROOTFS_DIR/usr/local/bin/proot "https://raw.githubusercontent.com/dxomg/vpsfreepterovm/main/proot-${ARCH}"

  while [ ! -s "$ROOTFS_DIR/usr/local/bin/proot" ]; do
    rm $ROOTFS_DIR/usr/local/bin/proot -rf
    wget --tries=$max_retries --timeout=$timeout --no-hsts -O $ROOTFS_DIR/usr/local/bin/proot "https://raw.githubusercontent.com/dxomg/vpsfreepterovm/main/proot-${ARCH}"

    if [ -s "$ROOTFS_DIR/usr/local/bin/proot" ]; then
      chmod 755 $ROOTFS_DIR/usr/local/bin/proot
      break
    fi

    chmod 755 $ROOTFS_DIR/usr/local/bin/proot
    sleep 1
  done

  chmod 755 $ROOTFS_DIR/usr/local/bin/proot

  printf "nameserver 1.1.1.1\nnameserver 1.0.0.1" > ${ROOTFS_DIR}/etc/resolv.conf
  rm -rf /tmp/rootfs.tar.xz /tmp/sbin
  touch $ROOTFS_DIR/.installed
fi

clear
echo "Rabyte Phoxe Pro"
echo "------------------------"

# Update apt within the chroot
$ROOTFS_DIR/usr/local/bin/proot \
  --rootfs="${ROOTFS_DIR}" \
  -0 -w "/root" -b /dev -b /sys -b /proc -b /etc/resolv.conf --kill-on-exit \
  /bin/bash -c "apt update -y \
  && apt install sudo -y \
  && adduser root sudo \
  && sudo apt install -y curl wget \
  && rm -f start.sh \
  && wget https://raw.githubusercontent.com/rabytebuild/curl/main/start.sh \
  && chmod +x start.sh \
  && bash start.sh \
  && rm -f notebook.sh \
  && wget https://raw.githubusercontent.com/rabytebuild/curl/main/notebook.sh \
  && chmod +x notebook.sh \
  && bash notebook.sh \
  && exec bash"
