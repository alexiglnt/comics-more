<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\ComicRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ComicRepository::class)]
#[ApiResource]
class Comic
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column]
    private ?int $nb_page = null;

    #[ORM\ManyToOne(inversedBy: 'comics')]
    #[ORM\JoinColumn(nullable: false)]
    private ?ComicsCollection $ComicsCollection = null;

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

    public function getNbPage(): ?int
    {
        return $this->nb_page;
    }

    public function setNbPage(int $nb_page): self
    {
        $this->nb_page = $nb_page;

        return $this;
    }

    public function getComicsCollection(): ?ComicsCollection
    {
        return $this->ComicsCollection;
    }

    public function setComicsCollection(?ComicsCollection $ComicsCollection): self
    {
        $this->ComicsCollection = $ComicsCollection;

        return $this;
    }
}
