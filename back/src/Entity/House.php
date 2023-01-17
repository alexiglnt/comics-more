<?php

namespace App\Entity;

use App\Repository\HouseRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;

#[ORM\Entity(repositoryClass: HouseRepository::class)]
class House
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['read'])]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups(['read'])]
    private ?string $name = null;

    #[ORM\OneToMany(mappedBy: 'house', targetEntity: ComicsCollection::class)]
    private Collection $collection;

    public function __construct()
    {
        $this->collection = new ArrayCollection();
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

    /**
     * @return Collection<int, ComicsCollection>
     */
    public function getCollection(): Collection
    {
        return $this->collection;
    }

    public function addCollection(ComicsCollection $collection): self
    {
        if (!$this->collection->contains($collection)) {
            $this->collection->add($collection);
            $collection->setHouse($this);
        }

        return $this;
    }

    public function removeCollection(ComicsCollection $collection): self
    {
        if ($this->collection->removeElement($collection)) {
            // set the owning side to null (unless already changed)
            if ($collection->getHouse() === $this) {
                $collection->setHouse(null);
            }
        }

        return $this;
    }
}
