
export function readTheComic(comic) {
    localStorage.setItem('currentComic', JSON.stringify(comic));
    this.$router.push({ path: `/Comics/${comic.name}` })
}