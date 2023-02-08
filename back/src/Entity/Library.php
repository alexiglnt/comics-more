<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\LibraryRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ApiResource]
#[ORM\Entity(repositoryClass: LibraryRepository::class)]
class Library
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $userID = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $comicsUserHas = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?int
    {
        return $this->userID;
    }

    public function setUserID(int $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getComicsUserHas(): ?string
    {
        return $this->comicsUserHas;
    }

    public function setComicsUserHas(string $comicsUserHas): self
    {
        $this->comicsUserHas = $comicsUserHas;

        return $this;
    }
}
