FROM archlinux/base

RUN pacman --noconfirm --quiet --needed -Sy base-devel tar wget grep

RUN useradd bob
RUN mkdir -p /home/bob/build
RUN chown -R bob /home/bob/build

USER bob

COPY --chown=bob ./build.sh /home/bob/build/build.sh
COPY ./10_bob.sudo /etc/sudoers.d/10_bob
RUN chmod +x /home/bob/build/build.sh
CMD cd /home/bob/build && ./build.sh
