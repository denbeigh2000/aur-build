FROM archlinux/base

RUN pacman --noconfirm --quiet -Syu
RUN pacman --noconfirm --quiet --needed -S base-devel tar grep wget
RUN rm -f /var/cache/pacman/pkg/*

RUN useradd bob
RUN mkdir -p /home/bob/build /out
RUN chown -R bob /home/bob /out

USER bob

COPY --chown=bob ./build.sh /home/bob/build/build.sh
COPY ./10_bob.sudo /etc/sudoers.d/10_bob
RUN chmod +x /home/bob/build/build.sh
CMD cd /home/bob/build && ./build.sh
