<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\ComicsCollectionRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ComicsCollectionRepository::class)]
#[ApiResource]
class ComicsCollection
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(length: 255)]
    private ?string $link = null;

    #[ORM\OneToMany(mappedBy: 'ComicsCollection', targetEntity: Comic::class)]
    private Collection $comics;

    public function __construct()
    {
        $this->comics = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getLink(): ?string
    {
        return $this->link;
    }

    public function setLink(string $link): self
    {
        $this->link = $link;

        return $this;
    }

    /**
     * @return Collection<int, Comic>
     */
    public function getComics(): Collection
    {
        return $this->comics;
    }

    public function addComic(Comic $comic): self
    {
        if (!$this->comics->contains($comic)) {
            $this->comics->add($comic);
            $comic->setComicsCollection($this);
        }

        return $this;
    }

    public function removeComic(Comic $comic): self
    {
        if ($this->comics->removeElement($comic)) {
            // set the owning side to null (unless already changed)
            if ($comic->getComicsCollection() === $this) {
                $comic->setComicsCollection(null);
            }
        }

        return $this;
    }
}
